//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by ahmed on 03/05/2023.
//

import SwiftUI

struct DailyWeatherView: View {
    @ObservedObject var weatherVM : WeatherViewModel
    
    var body: some View {
        ForEach(weatherVM.weather.daily) { weather in
            LazyVStack {
                dailyCell(weather: weather)
            }
        }
    }
    
    private func dailyCell (weather: DailyWeather) -> some View {
        HStack
        {
            Text(weatherVM.getDayFor(timestamp: weather.dt ?? 0).uppercased()).frame(width: 50)
            Spacer()
            
            Text("\(weatherVM.getTempFor(temp: weather.temp?.max ?? 0)) | \(weatherVM.getTempFor(temp: weather.temp?.min ?? 0)) ℃")
            Spacer()
            if let weatherIcon = weather.weather
            {
                weatherVM.getWeatherFor(icon: weatherIcon.count > 0 ? weatherIcon[0].icon! : "sun.max.fill")
                
            }
            else {
                weatherVM.getWeatherFor(icon: "sun.max.fill")
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal, 40)
        .padding(.vertical, 15)
        .background(RoundedRectangle(cornerRadius: 5).fill(LinearGradient(gradient: Gradient(colors: [Color(ColorsSaved.lighterBlue), Color(ColorsSaved.darkerBlue)]), startPoint: .topLeading, endPoint: .bottomTrailing)))
        .shadow(color: .white.opacity(0.1), radius: 2 , x: -2 , y: -2)
        .shadow(color: .black.opacity(0.2), radius: 2 , x: 2 , y: 2)
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(weatherVM: WeatherViewModel())
    }
}
