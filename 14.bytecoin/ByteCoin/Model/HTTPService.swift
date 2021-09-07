//
//  HTTPService.swift
//  ByteCoin
//
//  Created by Debora Del Vecchio on 06/09/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

protocol RequestBase {
    var path: String { get }
    var queryParameters: [String: String]? { get }
    var headers: [String: String]? { get }
}

protocol ResponseBase: Codable {}

struct MyError: Error {
    let errorType: String
}

protocol HTTPServiceBase {
    var baseURL: String { get }
    func executeGet<T: Decodable>(
        with requestBase: RequestBase,
        completionHandler: @escaping (_ responseData: T) -> Void,
        errorHandler: @escaping  (_ error: Error) -> Void
    )
}

extension HTTPServiceBase {
    func getFullUrl(request: RequestBase) -> URL? {
        let fullURL = "\(baseURL)\(request.path)"
        var components = URLComponents(string: fullURL)
        if let queryParams = request.queryParameters {
            components?.queryItems = queryParams.map({ (key: String, value: String) in
                return URLQueryItem(name: key, value: value)
            })
        }
        return components?.url
    }
    
    func parseJSON<T: Decodable>(jsonData: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: jsonData)
            return decodedData
        } catch {
            return nil
        }
    }
    
    func executeGet<T: Decodable>(with requestBase: RequestBase, completionHandler: @escaping (T) -> Void, errorHandler:  @escaping (Error) -> Void) {
        if let url = getFullUrl(request: requestBase) {
            let session = URLSession(configuration: .default)
            var request = URLRequest(url: url)
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil {
                    errorHandler(error!)
                }
                if let safeData = data {
                    if let response: T = parseJSON(jsonData: safeData) {
                        completionHandler(response)
                    } else {
                        errorHandler(MyError(errorType: "Couldn't get data"))
                    }
                }
                
            }
            task.resume()
        }
    }
}
