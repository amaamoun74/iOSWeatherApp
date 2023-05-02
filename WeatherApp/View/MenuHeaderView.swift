//
//  MenuHeaderView.swift
//  WeatherApp
//
//  Created by ahmed on 01/05/2023.
//

import SwiftUI

struct MenuHeaderView: View {
    @ObservedObject var weatherVM : WeatherViewModel
    @State private var searchText = "Cairo"
    var body: some View {
        HStack{
            TextField("", text: $searchText)
                .padding(.leading, 20)
            
            Button {
                weatherVM.city = searchText
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                    Image(systemName: "location.fill")
                }
            }
            .frame(width: 50, height: 50)
        }
        .foregroundColor(.white)
        .padding()
        .background(
            ZStack(alignment: .leading) {
                Image(systemName: "magnifyingglass")                    .foregroundColor(.white)
                    .padding(.leading, 10)
                RoundedRectangle(cornerRadius: 10)
                    .fill(.blue.opacity(0.5))
            }
        )
    }
}
struct MenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MenuHeaderView(weatherVM: WeatherViewModel())
    }
}
