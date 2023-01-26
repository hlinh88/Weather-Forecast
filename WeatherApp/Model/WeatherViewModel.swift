//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 26/1/2023.
//

import SwiftUI

public class WeatherViewModel: ObservableObject{
    @Published var cityName : String = "City name"
    @Published var temp : Int = 0
    @Published var icon: String = "icon"
    @Published var weatherCondition: String = "Weather condition"
    @Published var temp_min: Int = 0
    @Published var temp_max: Int = 0
    
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
            }
        }
    }
}


public class WeatherForecastModel : ObservableObject{
    @Published var forecastList : [WeatherForecastNextHour] = []
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService){
        self.weatherService = weatherService
    }
    
    public func fetchData(){
        weatherService.loadForecastData { weatherForecastHourModel in
            for index in 0..<weatherForecastHourModel.forecastList.count{
                DispatchQueue.main.async {
                    self.forecastList.append(WeatherForecastNextHour(time: weatherForecastHourModel.forecastList[index].time, temp: weatherForecastHourModel.forecastList[index].temp, icon: weatherForecastHourModel.forecastList[index].icon))
                }
            }
          
        }
    }
}
