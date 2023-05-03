//
//  MainWeatherView.swift
//  WeatherApp
//
//  Created by ahmed on 03/05/2023.
//

import SwiftUI

struct MainWeatherView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    var body: some View {
        VStack {
            CityNameView(city: weatherVM.city, date: weatherVM.date)
                .shadow(radius: 0)
            
            TodayWeatherView(weatherVM: weatherVM)
                .padding()
            
            HourlyWeatherView(weatherVM: weatherVM)
            
            DailyWeatherView(weatherVM: weatherVM)
        }
        .padding(.bottom,30)
    }
}

struct MainWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        MainWeatherView(weatherVM: WeatherViewModel())
    }
}
