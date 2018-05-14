//
//  Coin.swift
//  TutorialData
//
//  Created by Duy Tuan on 12/22/17.
//  Copyright © 2017 Duy Tuan. All rights reserved.
//

import Foundation
class Coin: Codable {
    var id: String?
    var name: String?
    var symbol: String?
    var rank: String?
    var priceUsd: String?
    var priceBtc: String?
    var volumeUsd24h: String?
    var marketCapUsd: String?
    var availableSupply: String?
    var totalSupple: String?
    var maxSupple: String?
    var percentChange1h: String?
    var percentChange7d: String?
    var percentChange24h: String?
    var lastUpdated: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case rank
        case priceUsd = "price_usd"
        case priceBtc = "price_btc"
        case volumeUsd24h = "24h_volume_usd"
        case marketCapUsd = "market_cap_usd"
        case availableSupply = "available_supply"
        case totalSupple = "total_supply"
        case maxSupple = "max_supply"
        case percentChange1h = "percent_change_1h"
        case percentChange7d = "percent_change_7d"
        case percentChange24h = "percent_change_24h"
        case lastUpdated = "last_updated"
    }
}
