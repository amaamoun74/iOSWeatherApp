//
//  ContentView.swift
//  WeatherApp
//
//  Created by ahmed on 05/04/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var weatherVM : WeatherViewModel
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                
                
                MenuHeaderView(weatherVM: weatherVM)
                ScrollView(showsIndicators: false) {
                    MainWeatherView(weatherVM: weatherVM)
                }
                .padding(.top, 10)
            }
            .padding(.top , 40)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color(ColorsSaved.lighterBlue), Color(ColorsSaved.darkerBlue)]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherVM: WeatherViewModel())
    }
}
