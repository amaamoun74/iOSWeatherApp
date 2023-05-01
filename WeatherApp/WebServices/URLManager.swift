//
//  URLManager.swift
//  WeatherApp
//
//  Created by ahmed on 08/04/2023.
//

import Foundation
struct URLManager {
    let API_KEY = "25fd09f561c3dbc9470ee5ff51ce2fcf"
    let BASE_URL = "https://api.openweathermap.org/data/3.0/"
    static let shared = URLManager()
    
    private init(){}
}

