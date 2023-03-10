//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 26/1/2023.
//

import SwiftUI

public class WeatherCityViewModel : ObservableObject{
    @Published var cityList : [WeatherCityModel] = []
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService){
        self.weatherService = weatherService
    }
    
    public func fetchDataByCityName(cityName : String){
        weatherService.loadWeatherByCityName({ weatherModel in
            DispatchQueue.main.async {
                self.cityList.append(WeatherCityModel(cityName: weatherModel.cityName, temp: weatherModel.temp, icon: weatherModel.icon, weatherCondition: weatherModel.weatherCondition, temp_min: weatherModel.temp_min, temp_max:  weatherModel.temp_max, timezone: weatherModel.timezone, hour: weatherModel.hour))
                print(self.cityList)
            }
        }, cityName : cityName)
    }
   
}

struct WeatherCityModel : Hashable{
    var id = UUID()
    var cityName : String
    var temp : Int
    var icon: String
    var weatherCondition: String
    var temp_min: Int
    var temp_max: Int
    var timezone : String
    var hour : Int
}

public class WeatherViewModel: ObservableObject{
    @Published var cityName : String = ""
    @Published var temp : Int = 0
    @Published var icon: String = ""
    @Published var weatherCondition: String = ""
    @Published var temp_min: Int = 0
    @Published var temp_max: Int = 0
    @Published var sunrise: String = ""
    @Published var sunset: String = ""
    @Published var sunriseNum: Int = 0
    @Published var sunsetNum: Int = 0
    
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
                self.sunriseNum = weatherModel.sunriseNum
                self.sunsetNum = weatherModel.sunsetNum
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

public class WeatherForecast10DayViewModel : ObservableObject{
    @Published var forecast10DayList : [Weather10Day] = []
    @Published var highest_temp : Int = 0
    @Published var lowest_temp : Int = 0
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService){
        self.weatherService = weatherService
    }
    
    public func fetchData(){
        weatherService.loadForecast10DayData { Weather10DayModel in
            DispatchQueue.main.async {
                self.forecast10DayList.append(contentsOf: Weather10DayModel.forecast10)
                self.highest_temp = Weather10DayModel.highest_temp
                self.lowest_temp = Weather10DayModel.lowest_temp
            }
        }
        
    }
}
