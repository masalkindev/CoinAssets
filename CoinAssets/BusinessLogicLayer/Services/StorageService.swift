//
//  StorageService.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 11.10.2022.
//

import CoreData

protocol StorageServiceProtocol {
    func getAll<T: NSManagedObject>(by name: String, predicate: NSPredicate?) -> [T]
    func add<T: StorageEntityCreating>(by name: String, fromEntity: T.Entity) -> T?
    func delete(by name: String, predicate: NSPredicate)
}

class StorageService: StorageServiceProtocol {
    
    static let storageDidAddEntity = "storageDidAddEntity"
    static let storageDidDeleteEntity = "storageDidDeleteEntity"
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoinAssets")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func getAll<T: NSManagedObject>(by name: String, predicate: NSPredicate?) -> [T] {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            return (result as? [T]) ?? []
        } catch {
            print("CoreData fetch error: \(error)")
            return []
        }
    }
    
    func add<T: StorageEntityCreating>(by name: String, fromEntity: T.Entity) -> T? {
        
        let object = NSEntityDescription.insertNewObject(forEntityName: name, into: persistentContainer.viewContext) as? T
        object?.create(from: fromEntity)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("CoreData save error: \(error)")
        }
        
        return object
        
    }
    
    func delete(by name: String, predicate: NSPredicate) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        fetchRequest.predicate = predicate
        
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            
            if let objectToDelete = result.first as? NSManagedObject {
                persistentContainer.viewContext.delete(objectToDelete)
                
                try persistentContainer.viewContext.save()
            }
        } catch {
            print("CoreData delete error: \(error)")
        }
        
    }

}
