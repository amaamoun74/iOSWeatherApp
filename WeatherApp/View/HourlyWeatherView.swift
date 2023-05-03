//
//  HourlyWeatherView.swift
//  WeatherApp
//
//  Created by ahmed on 02/05/2023.
//

import SwiftUI

struct HourlyWeatherView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            
            HStack(spacing: 20) {
                ForEach(weatherVM.weather.hourly) { weather in
                    let hour = weatherVM.getTimeFor(timestamp: weather.dt ?? 0)
                    
                    let temp = weatherVM.getTempFor(temp: weather.temp ?? 0.0)
                    
                    if let weatherIcon = weather.weather
                    {
                        let icon = weatherVM.getWeatherFor(icon: weatherIcon.count > 0 ? weatherIcon[0].icon! : "sun.max.fill")
                        getHourlyView(hour: hour, image: icon, temp: temp)

                    }
                    else {
                     let icon = Image(systemName: "sun.max.fill")
                        getHourlyView(hour: hour, image: icon, temp: temp)

                    }
                  
                }
            }
        }
    }
    
    private func getHourlyView(hour: String , image: Image, temp: String) -> some View
    {
        VStack(spacing: 20) {
            Text(hour)
            image.foregroundColor(.yellow)
            Text(temp)
        }
        .foregroundColor(.white)
        .padding()
        .background(RoundedRectangle(cornerRadius: 5).fill(LinearGradient(gradient: Gradient(colors: [Color(ColorsSaved.lighterBlue), Color(ColorsSaved.darkerBlue)]), startPoint: .topLeading, endPoint: .bottomTrailing)))
        .shadow(color: .white.opacity(0.1), radius: 2 , x: -2 , y: -2)
        .shadow(color: .black.opacity(0.2), radius: 2 , x: 2 , y: 2)
    }
    
}
struct HourlyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        HourlyWeatherView(weatherVM:  WeatherViewModel())
    }
}
    

