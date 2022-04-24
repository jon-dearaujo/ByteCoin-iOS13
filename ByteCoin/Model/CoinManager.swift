//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {

    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "8D1E46D6-6043-4982-AFB7-0ED37A20ACE0"

    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]


    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String) {
        if let url = URL(string: "\(baseURL)/\(currency)?apiKey=\(apiKey)") {

            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didCompleteWithError("Error loading data for BTC/\(currency)")
                }

                if let coinPriceData = data {
                    delegate?.didCoinPriceLoad(parseJSON(priceData: coinPriceData, currency: currency))
                }
            }.resume()
        } else {
            delegate?.didCompleteWithError("Error building url for BTC/\(currency)")
        }
    }

    private func parseJSON(priceData: Data, currency: String) -> CoinPriceData? {
        let decoder = JSONDecoder()

        do {
            return try decoder.decode(CoinPriceData.self, from: priceData)
        } catch {
            delegate?.didCompleteWithError("Error parsing data for BTC/\(currency): \(error)")
            return nil
        }
    }
}
