//
//  ForecastModel.swift
//  WeatherForecast
//
//  Created by ПавелК on 06.03.2022.
//

import Foundation

class ForecastModel {
    
    var city : String
    var timeStamp : Date
    var dayTemp : Int
    var nightTemp : Int
    var windSpeed : Int
    var windDirect : WindDirection
    
    init(city : String,timeStamp : Date,dayTemp : Int,nightTemp : Int,windSpeed : Int,windDirect : WindDirection) {
        self.city = city
        self.timeStamp = timeStamp
        self.dayTemp = dayTemp
        self.nightTemp = nightTemp
        self.windSpeed = windSpeed
        self.windDirect = windDirect
    }
    
}
