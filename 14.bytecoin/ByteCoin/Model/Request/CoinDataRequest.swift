//
//  CoinDataRequest.swift
//  ByteCoin
//
//  Created by Debora Del Vecchio on 06/09/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinDataRequest: RequestBase {
    init(quote: String) {
        path = "/\(quote)"
    }
    var path: String
    var queryParameters: [String : String]? = ["apikey": CoinDataHTTPService.apiKey]
    var headers: [String : String]?
}
