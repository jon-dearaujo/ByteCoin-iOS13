//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!

    var coinManager = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self

        coinManager.getCoinPrice(for: coinManager.currencyArray.first!)
    }
}

// MARK: - UIPickerDataSource

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

// MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
}


// MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func didCompleteWithError(_ error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error loading quotes", message: "Something went wrong while loading quotes for BTC.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                print("OK")
            })
            self.present(alert, animated: true, completion: nil)
        }
    }

    func didCoinPriceLoad(_ data: CoinPriceData?) {
        DispatchQueue.main.async {
            if data != nil {
                self.bitcoinLabel.text = String(format: "%.3f", data!.rate)
                self.currencyLabel.text = data!.asset_id_quote
            }
        }
    }
}
