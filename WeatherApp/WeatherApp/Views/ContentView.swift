//
//  ContentView.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 20/1/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var data : OurData
    @ObservedObject var weatherViewModel : WeatherViewModel
    @ObservedObject var weatherForecastViewModel : WeatherForecastViewModel
    @ObservedObject var weather10DayViewModel : WeatherForecast10DayViewModel
    var body: some View {
        GeometryReader{proxy in
            let topEdge = proxy.safeAreaInsets.top
            Home(data: data, weatherViewModel: weatherViewModel, weatherForecastViewModel: weatherForecastViewModel, weather10DayViewModel: weather10DayViewModel,  topEdge: topEdge)
                .ignoresSafeArea(.all, edges: .top)
        }
       
    }
}


