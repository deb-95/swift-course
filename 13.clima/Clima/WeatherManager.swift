//
//  WeatherManager.swift
//  Clima
//
//  Created by Debora Del Vecchio on 03/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

let apiKey = ""

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=\(apiKey)&units=metric"
    
    func fetchWeather(cityName: String) {
        let fullWeatherURL = weatherURL + "&q=\(cityName)"
        performRequest(fullWeatherURL)
    }
    
    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url, completionHandler: handle)
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error:Error?) -> Void {
        if error != nil {
            print(error!)
            return;
        }

        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString!)
        }
    }
}
