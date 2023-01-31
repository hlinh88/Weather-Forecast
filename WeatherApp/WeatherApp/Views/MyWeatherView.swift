//
//  MyWeatherView.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 31/1/2023.
//

import SwiftUI

struct MyWeatherView: View {
    var body: some View {
        VStack{
            GeometryReader{ proxy in
                Text("Weather")
                    .font(.custom("HelveticaNeue-Bold", size: 35))
            }
        }
    }
}

