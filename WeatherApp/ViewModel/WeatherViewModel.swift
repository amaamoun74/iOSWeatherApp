//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by ahmed on 05/04/2023.
//

import SwiftUI
import CoreLocation

final class WeatherViewModel : ObservableObject{
    
    @Published var weather = WeatherResponse.empty()
    @Published var city : String = "Cairo" {
        didSet {
            getLocation()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init() {
        getLocation()
    }
    
    var date : String {
        if let date = weather.current.dt {
            return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)))
        }
        else { return "" }
    }
    
    var weatherIcon : String {
        if let icon = weather.current.weather, weather.current.weather?.count ?? 0 > 0 {
            return icon[0].icon!
        }
        else { return "sun.max.fill" }
    }
    
    var condition : String {
        if let condition = weather.current.weather, weather.current.weather?.count ?? 0 > 0 {
            return condition[0].main!
        }
        else { return "" }
    }
    
    var windSpeed: String {
        if let speed = weather.current.wind_speed {
            return String(format: "%0.1f", speed)
        }
        else { return "" }
    }
    
    var humidity: String {
        if let humidity = weather.current.humidity {
            return String(format: "%d%%", humidity)
        }
        else { return "" }
    }
    
    var rainChances: String {
        if let chances = weather.current.dew_point {
            return String(format: "%0.0f%%", chances)
        }
        else { return "" }
    }
    
    var temprature: String {
        if let temp = weather.current.temp {
            return getTempFor(temp: temp)
        }
        else {
            return ""
        }
    }
    
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }
    
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getDayFor(timestamp : Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    private func getLocation(){
        CLGeocoder().geocodeAddressString(city) { placeMarks, error in
            if let places = placeMarks , let place = places.first
            {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    private func getWeather(coord: CLLocationCoordinate2D?){
        if let coord = coord {
            let url = URLManager.shared.getURLFor(lat: coord.latitude, lon: coord.longitude)
            getWeatherInternal(city: city, for: url)
        }
        else {
            let url = URLManager.shared.getURLFor(lat: 46.85623, lon: 51.84)
            getWeatherInternal(city: city, for: url)
        }
    }
    
    private func getWeatherInternal(city: String , for urlString: String)
    {
        NetworkManager<WeatherResponse>.fetch(for: URL(string: urlString)!) {
            result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weather = response
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
