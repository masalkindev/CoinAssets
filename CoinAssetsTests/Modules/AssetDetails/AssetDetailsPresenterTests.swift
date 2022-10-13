//
//  AssetDetailsPresenterTests.swift
//  CoinAssetsTests
//
//  Created by Андрей Масалкин on 13.10.2022.
//

import XCTest
@testable import CoinAssets

final class AssetDetailsPresenterTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: AssetDetailsPresenter!
    var vc: AssetDetailsViewControllerMock!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        
        setupListOrdersPresenter()
    }
    
    override func tearDown() {
        
        sut = nil
        vc = nil
        
        super.tearDown()
    }
    
    // MARK: - Test setup
    func setupListOrdersPresenter() {
        
        vc = AssetDetailsViewControllerMock()
        sut = AssetDetailsPresenter()
        
        sut.viewController = vc
    }
    
    // MARK: - Mocks
    
    class AssetDetailsViewControllerMock: AssetDetailsDisplayLogic {
        
        var titleAttrString: NSAttributedString!
        var inWatchlist: Bool = false
        var headerModel: AssetDetailsHeaderViewModel!
        var propertyModels: [PlainTableViewModel] = []
        var errorMessage: String!
        
        func displayTitle(with attrString: NSAttributedString) {
            
            self.titleAttrString = attrString
        }
        func displayHeart(with inWatchlist: Bool) {
            
            self.inWatchlist = inWatchlist
        }
        func displayAsset(with headerModel: AssetDetailsHeaderViewModel, propertyModels: [PlainTableViewModel]) {
            
            self.headerModel = headerModel
            self.propertyModels = propertyModels
            
        }
        func displayAlertError(with error: String) {
            
            self.errorMessage = error
        }
        
    }

    // MARK: - Tests
    
    func testPresentationLogic() {
        
        let asset = Asset(
            id: "bitcoin",
            symbol: "BTC",
            name: "Bitcoin",
            priceUsd: "6929.8217756835584756",
            supply: "17193925.0000000000000000",
            marketCapUsd: "119150835874.4699281625807300",
            volumeUsd24Hr: "2927959461.1750323310959460",
            changePercent24Hr: "-0.8101417214350335"
        )
        
        let assetHistories = [
            AssetHistory(priceUsd: "6379.3997635993342453", time: 1530403200000),
            AssetHistory(priceUsd: "6466.3135622762295280", time: 1530489600000)
        ]
        
        sut.presentHeart(true)
        sut.presentAlertError("Internet Connection appears to be offline")
        sut.presentAssetDetails(asset, assetHistories: assetHistories)
        
        XCTAssertEqual(vc.inWatchlist, true, "Presenting heart should properly format inWatchlist")
        XCTAssertEqual(vc.errorMessage, "Internet Connection appears to be offline", "Presenting alert error should properly format error")
        XCTAssertEqual(vc.headerModel.price, "$6,929.82", "Presenting asset details should properly format price")
        XCTAssertEqual(vc.headerModel.percent, "-0.81%", "Presenting asset details should properly format percent")
        XCTAssertEqual(vc.headerModel.percentColor, "#FF3B30", "Presenting asset details should properly format percent color")
        XCTAssertNotNil(vc.headerModel.chartPoints, "Presenting asset details should properly format chart points")
        XCTAssertEqual(vc.propertyModels[0].value, "$119,150,835,874.47", "Presenting asset details should properly format property Market Cap")
        XCTAssertEqual(vc.propertyModels[1].value, "$17,193,925", "Presenting asset details should properly format property Supply")
        XCTAssertEqual(vc.propertyModels[2].value, "$2,927,959,461.18", "Presenting asset details should properly format property Volume")
    }

}
