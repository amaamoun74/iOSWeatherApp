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

    // for current weather state
    func getLottieAnimationFor(icon: String) -> String{
        switch icon {
        case "01d" :
            return "dayClearSky"
        
        case "01n" :
            return "nightClearSky"
        
        case "02d" :
            return "dayFewClouds"
        
        case "02n" :
            return "nightFewClouds"
        
        case "03d" :
            return "dayScatteredClouds"
        
        case "03n" :
            return "nightScatteredClouds"
        
        case "04d" :
            return "dayBrokenClouds"
        
        case "04n" :
            return "nightBrokenClouds"
     
        case "09d" :
            return "dayShowerClouds"
        
        case "09n" :
            return "nightShowerClouds"
        
        case "10d" :
            return "dayRain"
        
        case "10n" :
            return "nightRain"
        
        case "11d" :
            return "dayThunderStorm"
        
        case "11n" :
            return "nightThunderStorm"
        
        case "13d" :
            return "daySnow"
        
        case "13n" :
            return "nightSnow"
        
        case "50d" :
            return "dayMist"
            
        case "50n" :
            return "dayMist"
        default:
            return "dayClearSky"
        }
    }

    
    // for daily and hourly weather state
    func getWeatherFor(icon: String) -> Image{
        switch icon {
        case "01d" :
            return  Image(systemName: "sun.max.fill") //"dayClearSky"
        
        case "01n" :
            return Image(systemName: "moon.fill") //"nightClearSky"
        
        case "02d" :
            return Image(systemName: "cloud.sun.fill") //"dayFewClouds"
        
        case "02n" :
            return Image(systemName: "cloud.moon.fill") //"nightFewClouds"
        
        case "03d" :
            return Image(systemName: "cloud.fill") //"dayScatteredClouds"
        
        case "03n" :
            return Image(systemName: "cloud.fill") //"nightScatteredClouds"
        
        case "04d" :
            return Image(systemName: "cloud.fill") //"dayBrokenClouds"
        
        case "04n" :
            return Image(systemName: "cloud.fill") //"nightBrokenClouds"
     
        case "09d" :
            return Image(systemName: "cloud.drizzle.fill") //"dayShowerClouds"
        
        case "09n" :
            return Image(systemName: "cloud.drizzle.fill") //"nightShowerClouds"
        
        case "10d" :
            return Image(systemName: "cloud.heavyrain.fill") //"dayRain"
        
        case "10n" :
            return Image(systemName: "cloud.heavyrain.fill") //"nightRain"
        
        case "11d" :
            return Image(systemName: "cloud.bolt.fill") //"dayThunderStorm"
        
        case "11n" :
            return Image(systemName: "cloud.bolt.fill") //"nightThunderStorm"
        
        case "13d" :
            return Image(systemName: "cloud.snow.fill") //"daySnow"
        
        case "13n" :
            return Image(systemName: "cloud.snow.fill") //"nightSnow"
        
        case "50d" :
            return Image(systemName: "cloud.fog.fill") //"dayMist"
            
        case "50n" :
            return Image(systemName: "cloud.fog.fill") //"dayMist"
        default:
            return Image(systemName: "sun.max.fill") //"dayClearSky"
        }
    }

}
