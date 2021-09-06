//
//  WeatherManager.swift
//  Clima
//
//  Created by Debora Del Vecchio on 03/09/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

let apiKey = ""

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ weatherManager: WeatherManager, error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=\(apiKey)&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let fullWeatherURL = weatherURL + "&q=\(cityName)"
        performRequest(fullWeatherURL)
    }
    
    func fetchWeather(lat: Double, lon: Double) {
        let fullWeatherURL = weatherURL + "&lat=\(lat)&lon=\(lon)"
        performRequest(fullWeatherURL)
    }
    
    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return;
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let cityName = decodedData.name
            let conditionID = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            let weatherModel = WeatherModel(conditionId: conditionID, cityName: cityName, temperature: temperature)
            return weatherModel
        } catch {
            delegate?.didFailWithError(self, error: error)
            return nil
        }
    }

}
