//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 26/1/2023.
//

import SwiftUI

public struct WeatherModel {
    var cityName : String
    var temp : Int
    var icon: String
    var weatherCondition: String
    var temp_min: Int
    var temp_max: Int
    
    init(response: APICurrentWeather) {
        cityName = response.name
        temp = Int(response.main.temp)
        icon = getWeatherIcon(id: response.weather[0].id)
        weatherCondition = response.weather[0].description.capitalized
        temp_min = Int(response.main.temp_min.rounded())
        temp_max = Int(response.main.temp_max.rounded())
    }
    
   
}

func getWeatherIcon(id: Int) -> String {
    switch id{
    case 200...232:
        return "cloud.bolt.rain.fill"
    case 300...321:
        return "cloud.drizzle.fill"
    case 500...531:
        return "cloud.rain.fill"
    case 600...622:
        return "cloud.snow.fill"
    case 701...781:
        return "cloud.fog.fill"
    case 800:
        return "sun.max.fill"
    case 801...804:
        return "cloud.fill"
    default:
        return "cloud.fill"

    }
}


public struct WeatherForecastHourModel{
    var forecastList : [WeatherForecastNextHour]
    
    init(response: APIForecastWeather) {
        let currentTimezone = 7
        var list : [WeatherForecastNextHour] = []
        for index in 0..<response.list.count{
            var hour = ""
            var convertedTime = Int(response.list[index].dt_txt.substring(with: 11..<13))! + currentTimezone
            if(convertedTime > 24){
                convertedTime = convertedTime - 24
            }
            if(convertedTime > 12){
                if(convertedTime == 24){
                    hour = "12AM"
                }else{
                    convertedTime = convertedTime % 12
                    hour = "\(convertedTime)PM"
                }
            }else if(convertedTime == 12){
                hour = "12PM"
            }
            else{
                hour = "\(convertedTime)AM"
            }
            let time = "\(hour)"
            let temp = Int(response.list[index].main.temp.rounded())
            let icon = getWeatherIcon(id: response.list[index].weather[0].id)
            list.append(WeatherForecastNextHour(time: time, temp: temp, icon: icon))
        }
        forecastList = list
    }
}

struct WeatherForecastNextHour{
    var time : String
    var temp : Int
    var icon : String
}

