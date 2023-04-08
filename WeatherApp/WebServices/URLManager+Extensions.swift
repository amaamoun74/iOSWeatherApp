//
//  URLManager+Exetension.swift
//  WeatherApp
//
//  Created by ahmed on 08/04/2023.
//

import Foundation

extension URLManager{
     static let BASE_URL = "https://api.openweathermap.org/data/3.0/"
     
    static func getURLFor(lat: Double , lon: Double) -> String {
        return "\(BASE_URL)onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(API_KEY)&units=standard"
    }
}
