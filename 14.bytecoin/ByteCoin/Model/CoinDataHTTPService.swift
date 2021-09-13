//
//  CoinDataHTTPService.swift
//  ByteCoin
//
//  Created by Debora Del Vecchio on 07/09/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinDataHTTPService: HTTPServiceBase {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    static let apiKey = ""
    
    func getCoinData(with request: RequestBase, onData: @escaping (_ data: Result<CoinDataResponse, Error>) -> Void) {
        executeGet(with: request, completionHandler: onData)
    }
}
