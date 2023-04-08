//
//  weatherModel.swift
//  WeatherApp
//
//  Created by ahmed on 05/04/2023.
//

import Foundation

struct WeatherResponse : Codable {
    var current: CurrentWeather
    var hourly: [CurrentWeather]
    var daily: [DailyWeather]
    
    static func empty() -> WeatherResponse {
        return WeatherResponse(current: CurrentWeather(), hourly: [CurrentWeather](repeating: CurrentWeather() , count: 23), daily: [DailyWeather](repeating: DailyWeather(), count: 8))
    }
    
}
