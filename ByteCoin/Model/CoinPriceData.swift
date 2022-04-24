//
//  CoinPriceData.swift
//  ByteCoin
//
//  Created by Jonathan De Araújo Silva on 24/04/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinPriceData: Codable {
    let rate: Double
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
}
