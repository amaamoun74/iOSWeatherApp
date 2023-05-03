//
//  URLManager+Exetension.swift
//  WeatherApp
//
//  Created by ahmed on 08/04/2023.
//

import Foundation

extension URLManager{
    
    func getURLFor(lat: Double , lon: Double) -> String {
        return "\(BASE_URL)onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(API_KEY)&units=standard"
    }
    
   /* func getURLFor(city: String) -> String {
        return "\(BASE_URL)onecall?lat=&lon=&exclude=minutely&appid=\(API_KEY)&units=standard"
    }*/
}
