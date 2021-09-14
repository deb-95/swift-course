//
//  HttpService.swift
//  WhatFlower
//
//  Created by Debora Del Vecchio on 14/09/21.
//

import Foundation
import Alamofire

struct HttpService {
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    func getFlowerInfo(
        flowerName: String,
        onSuccess: @escaping (_ flowerDTO: WikipediaResponse) -> Void,
        onError: @escaping (_ error: Error) -> Void
    ) {
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize": "500"
        ]
        
        Alamofire.AF.request(
            wikipediaURl,
            parameters: parameters,
            headers: [
                "Accept": "application/json"
            ]
        ).validate().response { response in
            switch response.result {
                case .success(let data):
                    if let safeData = data {
                        let decoder = JSONDecoder()
                        let response = try! decoder.decode(WikipediaResponse.self, from: safeData)
                        onSuccess(response)
                    }
                case .failure(let error):
                    onError(error)
                }
        }
        
    }
}
