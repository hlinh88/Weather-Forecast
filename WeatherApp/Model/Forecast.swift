//
//  Forecast.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 23/1/2023.
//

import SwiftUI

struct DayForecast: Identifiable{
    var id = UUID().uuidString
    var day: String
    var celcius: CGFloat
    var image: String
}

var forecast = [
    DayForecast(day: "Today", celcius: 18, image: "sun.min"),
    DayForecast(day: "Tue", celcius: 18, image: "cloud.sun"),
    DayForecast(day: "Wed", celcius: 18, image: "cloud.sun.bolt"),
    DayForecast(day: "Thu", celcius: 18, image: "sun.max"),
    DayForecast(day: "Fri", celcius: 18, image: "cloud.sun"),
    DayForecast(day: "Sat", celcius: 18, image: "cloud.sun"),
    DayForecast(day: "Sun", celcius: 18, image: "sun.max"),
    DayForecast(day: "Tue", celcius: 18, image: "sun.max"),
    DayForecast(day: "Wed", celcius: 18, image: "cloud.sun.bolt"),
    DayForecast(day: "Thu", celcius: 18, image: "sun.min"),
]
