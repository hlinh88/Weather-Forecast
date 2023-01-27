//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 26/1/2023.
//

import SwiftUI

public class WeatherViewModel: ObservableObject{
    @Published var cityName : String = ""
    @Published var temp : Int = 0
    @Published var icon: String = ""
    @Published var weatherCondition: String = ""
    @Published var temp_min: Int = 0
    @Published var temp_max: Int = 0
    @Published var sunrise: String = ""
    @Published var sunset: String = ""
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService){
        self.weatherService = weatherService
    }
    
    public func fetchData(){
        weatherService.loadWeatherData { weatherModel in
            DispatchQueue.main.async {
                self.cityName = weatherModel.cityName
                self.temp = weatherModel.temp
                self.icon = weatherModel.icon
                self.weatherCondition = weatherModel.weatherCondition
                self.temp_min = weatherModel.temp_min
                self.temp_max = weatherModel.temp_max
                self.sunrise = weatherModel.sunrise
                self.sunset = weatherModel.sunset
            }
        }
    }
}


public class WeatherForecastViewModel : ObservableObject{
    @Published var forecastList : [WeatherForecastNextHour] = []
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService){
        self.weatherService = weatherService
    }
    
    public func fetchData(){
        weatherService.loadForecastData { weatherForecastHourModel in
                DispatchQueue.main.async {
                    self.forecastList.append(contentsOf: weatherForecastHourModel.forecastList)
                }
        }
      
    }
}
