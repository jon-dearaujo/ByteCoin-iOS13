//
//  CoinManagerDelegate.swift
//  ByteCoin
//
//  Created by Jonathan De Araújo Silva on 24/04/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didCompleteWithError(_ error: String)
    func didCoinPriceLoad(_ data: CoinPriceData?)
}
