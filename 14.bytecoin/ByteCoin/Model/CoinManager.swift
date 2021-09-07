//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func onModel(model: CoinModel)
    func onError(error: Error)
}

struct CoinManager {
    let coinService = CoinDataHTTPService()
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for quote: String) {
        coinService.getCoinData(with: CoinDataRequest(quote: quote), onData: onData, onError: onError)
    }
    
    func onData(data: CoinDataResponse) {
        let model = CoinModel(value: data.rate)
        delegate?.onModel(model: model)
    }
    
    func onError(error: Error) {
        delegate?.onError(error: error)
    }
    
}
