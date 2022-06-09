//
//  CurrentWeatherData.swift
//  WeatherForecast
//
//  Created by ПавелК on 15.02.2022.
//

import Foundation

class CurrentWeatherData : Decodable {
    
    var name = ""
    var main = ["temp" : 0.0,
                    "feelsLike": 0.0,
                    "pressure" : 0.0,
                    "humidity" : 0.0]
    var wind = ["speed" : 0.0,
                    "deg" : 0.0]
}
