//
//  CoinDataResponse.swift
//  ByteCoin
//
//  Created by Debora Del Vecchio on 06/09/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinDataResponse: ResponseBase {
// time    Time in ISO 8601 of the market data used to calculate exchange rate
    let asset_id_base: String // Exchange rate base asset identifier
    let asset_id_quote: String // Exchange rate quote asset identifier
    let rate: Double // Exchange rate between assets
}
