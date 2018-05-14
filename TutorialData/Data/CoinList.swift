//
//  coinList.swift
//  TutorialData
//
//  Created by Duy Tuan on 12/22/17.
//  Copyright © 2017 Duy Tuan. All rights reserved.
//

import Foundation
import Alamofire

class CoinList {
    var coinList = [Coin]()
    var coinSetSearching = [Coin]()
    var coiQtyWillAdd:Int = 0
    
    func getCoin(tableView: UITableView?) {
        
        Alamofire.request("https://api.coinmarketcap.com/v1/ticker/?limit=1000").responseJSON{ response in
            print(response.value!)
//            let decoder = JSONDecoder()
//            let countQty = self.coiQtyWillAdd + 20
//
//            do {
//                let coinCollection = try decoder.decode([Coin].self, from: response.data!)
//                for index in self.coiQtyWillAdd..<countQty {
//                    if index < 1000 {
//                        self.coinList.append(coinCollection[index])
//                    }
//                }
//                self.coiQtyWillAdd = countQty
//                self.coinSetSearching = self.coinList
//                tableView.reloadData()
//            }catch let error {
//                print(error.localizedDescription)
//            }
        }
    }
    
    func getCoins(completion: @escaping ([[String: Any]]) -> Void) {
        
        Alamofire.request("https://api.coinmarketcap.com/v1/ticker/?limit=2").responseJSON{ response in
            completion(response.value! as! [[String: Any]])
        }
    }

    func searchCoin(text: String, tableView: UITableView) {
        coinSetSearching = [Coin]()
        if !text.isEmpty {
            for coin in self.coinList {
                let charOfCoin = Array(coin.name!)
                let symbolName = Array(coin.symbol!)
                if text.lowercased().elementsEqual(String(symbolName).lowercased()) {
                    self.coinSetSearching.append(coin)
                }
                else if charOfCoin.count > text.count, text.lowercased().elementsEqual(String(charOfCoin[..<text.count]).lowercased()) {
                    self.coinSetSearching.append(coin)
                }
            }
            tableView.reloadData()
        }
    }
}
