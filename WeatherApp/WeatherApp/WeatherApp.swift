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
    let weatherForecastModel = WeatherForecastModel(weatherService: WeatherService())

    init(){
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView(data: data, weatherViewModel: weatherViewModel, weatherForecastModel: weatherForecastModel)
        }
    }
}
