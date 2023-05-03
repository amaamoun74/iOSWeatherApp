//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by ahmed on 08/04/2023.
//

import Foundation
class DailyWeather: Codable {
    var dt: Int?
    var temp: Temprature?
    var weather: [Weather]?
}

extension DailyWeather: Identifiable {
    var id: UUID {
        return UUID()
    }
}
