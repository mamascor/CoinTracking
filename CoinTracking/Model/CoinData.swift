//
//  CoinData.swift
//  CoinTracking
//
//  Created by Marco Mascorro on 10/15/22.
//

import Foundation

struct CoinData: Decodable {
    let data: MoreCoinData
}

struct MoreCoinData: Decodable {
    let coins: [Coins]
}

struct Coins: Decodable {
    let uuid: String
    let symbol: String
    let name: String
    let price: String
}

