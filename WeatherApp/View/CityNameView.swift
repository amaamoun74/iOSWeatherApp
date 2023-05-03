//
//  CityNameView.swift
//  WeatherApp
//
//  Created by ahmed on 02/05/2023.
//

import SwiftUI

struct CityNameView: View {
    var city: String
    var date: String
    
    var body: some View {
        VStack(alignment: .center,spacing: 10) {
            Text(city)
                .font(.title)
                .bold()
            Text(date)
        }.foregroundColor(.white)
   
    }
}

struct CityNameView_Previews: PreviewProvider {
    static var previews: some View {
        CityNameView(city: "cairo", date: "14/11/1999")
    }
}
