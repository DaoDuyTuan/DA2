//
//  CoinViewController.swift
//  TutorialData
//
//  Created by Duy Tuan on 2/25/18.
//  Copyright © 2018 Duy Tuan. All rights reserved.
//

import UIKit
import SwiftDataTables

class CoinViewController: UIViewController {

    var dataTable: SwiftDataTable! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            UINavigationBar.appearance().prefersLargeTitles = true
        } else {
            self.navigationController?.navigationBar.isTranslucent = false
        }
        self.title = "COIN CAP"
        var options = DataTableConfiguration()
        options.defaultOrdering = DataTableColumnOrder(index: 1, order: .ascending)
        
        var dataSet: [[String]] = []
        let coinList = CoinList()
        coinList.getCoins{ data in
            for value in data {
                for name in value.values {
                    if let coin = name as? String {
                        dataSet.append([coin])
                    }
                }
            }
            
            self.dataTable = SwiftDataTable(
                data: dataSet,
                headerTitles: self.columnHeaders(),
                options: options
            )
            
            self.automaticallyAdjustsScrollViewInsets = false
            self.dataTable.backgroundColor = UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
            self.dataTable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.dataTable.frame = self.view.frame
            self.view.addSubview(self.dataTable)
        }
    }
}

extension CoinViewController {
    func columnHeaders() -> [String] {
        return [
            "id",
            "name",
            "symbol",
            "rank",
            "price_usd",
            "price_btc",
            "24h_volume_usd",
            "market_cap_usd",
            "available supply",
            "total_supply",
            "max_supply",
            "percent_change_1h",
            "percent_change_24h",
            "percent_change_7h",
            "last_updated"
        ]
    }
}
