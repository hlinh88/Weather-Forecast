//
//  WeatherApp.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 20/1/2023.
//

import SwiftUI


@main
struct WeatherApp: App {
    let data = OurData()
    let weatherViewModel = WeatherViewModel(weatherService: WeatherService())
    let weatherForecastViewModel = WeatherForecastViewModel(weatherService: WeatherService())
    let weather10DayViewModel = WeatherForecast10DayViewModel(weatherService: WeatherService())

    init(){
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView(data: data, weatherViewModel: weatherViewModel, weatherForecastViewModel: weatherForecastViewModel, weather10DayViewModel: weather10DayViewModel)
        }
    }
}
