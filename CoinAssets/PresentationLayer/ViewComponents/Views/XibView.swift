//
//  XibView.swift
//  CoinAssets
//
//  Created by Андрей Масалкин on 12.10.2022.
//

import UIKit

class XibView: UIView {
    
    var targetView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
        awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
        awakeFromNib()
    }
    
    func commonInit() {
        targetView = loadViewFromNib()
        targetView.frame = bounds
        targetView.translatesAutoresizingMaskIntoConstraints = false
        targetView.backgroundColor = .clear
        
        addSubview(targetView)
        
        backgroundColor = .clear
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|", metrics: nil, views: ["childView": targetView as Any]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|", metrics: nil, views: ["childView": targetView as Any]))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        targetView.frame = bounds
    }
    
    private func loadViewFromNib() -> UIView? {
        guard let name = type(of: self).description().components(separatedBy: ".").last else {
            return nil
        }
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
    }
}
