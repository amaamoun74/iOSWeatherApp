//
//  TodayWeatherView.swift
//  WeatherApp
//
//  Created by ahmed on 02/05/2023.
//

import SwiftUI

struct TodayWeatherView: View {
    @ObservedObject var weatherVM: WeatherViewModel
    var body: some View {
        VStack(spacing: 10) {
            Text("Today")
                .font(.largeTitle)
                .bold()
            
            HStack(spacing: 20) {
                LottieView(name: weatherVM.getLottieAnimationFor(icon: weatherVM.weatherIcon))
                    .frame(width: 100, height: 100)
                
                VStack(alignment: .leading) {
                    Text("\(weatherVM.temprature) ℃")
                        .font(.system(size: 42))
                    
                    Text(weatherVM.condition)
                }
            }
            HStack {
                Spacer()
                
                widgetView(image: "wind", color: .green , title: "\(weatherVM.windSpeed)mi/hr" )
                
                Spacer()
                
                widgetView(image: "drop.fill", color: .blue , title: "\(weatherVM.humidity)" )
                
                Spacer()
                
                widgetView(image: "umbrella.fill", color: .red , title: "\(weatherVM.rainChances)" )
                
                Spacer()
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), .blue]), startPoint: .top, endPoint: .bottom)).opacity(0.3))
        .shadow(color: .white.opacity(0.1), radius: 2, x: -2 , y: -2)
        .shadow(color: .black.opacity(0.2), radius: 2, x: 2 , y: 2)
    }
}

private func widgetView(image: String, color: Color , title: String) -> some View {
    VStack{
        Image(systemName: image)
            .padding()
            .font(.title)
            .foregroundColor(color)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        
        Text(title)
    }
}

struct TodayWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        TodayWeatherView(weatherVM: WeatherViewModel())
    }
}
