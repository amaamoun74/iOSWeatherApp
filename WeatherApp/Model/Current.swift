//
//  WeatherDetail.swift
//  WeatherApp
//
//  Created by ahmed on 08/04/2023.
//

import Foundation
class Current : Codable {
    var dt: Int64?
    var temp: Double?
    var feels_like: Double?
    var pressure: Int?
    var humidity: Int?
    var dew_point: Double?
    var clouds: Int?
    var wind_speed: Double?
    var wind_deg: Int64?
    var weather: [Weather]?
}

extension Current : Identifiable {
    var id : UUID {
        return UUID()
    }
}
