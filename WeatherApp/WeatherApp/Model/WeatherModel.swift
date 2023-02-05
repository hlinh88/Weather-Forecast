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
    var sunrise : String
    var sunset : String
    var sunriseNum : Int
    var sunsetNum : Int
    var dt : String
    var timezone : String
    var hour : Int
    
    init(response: APICurrentWeather) {
        cityName = response.name
        temp = Int(response.main.temp)
        icon = getWeatherIconHour(id: response.weather[0].id)
        weatherCondition = response.weather[0].description.capitalized
        temp_min = Int(response.main.temp_min.rounded())
        temp_max = Int(response.main.temp_max.rounded())
        sunrise = "\(getTimeStringFromTimeStamp(timeStamp: Double(response.sys.sunrise)))"
        sunset = "\(getTimeStringFromTimeStamp(timeStamp: Double(response.sys.sunset)))"
        sunriseNum = Int(getTimeNumFromTimeStamp(timeStamp: Double(response.sys.sunrise)).substring(with: 0..<2))!
        sunsetNum = Int(getTimeNumFromTimeStamp(timeStamp: Double(response.sys.sunset)).substring(with: 0..<2))!
        dt = timeStampFormat(timeStamp: Double(response.dt))
        timezone = toLocalTime(timezone: response.timezone)
        hour = getOnlyHour(timezone: response.timezone)
    }
    
   
}


func toLocalTime(timezone: Int) -> String {
    let currentDate = Date()

    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(secondsFromGMT:0)
    formatter.dateFormat = "HH:mma"
    let defaultTimeZoneStr = formatter.string(from: currentDate)
    let timezoneOffset = timezone / 3600
    var convertedTime = Int(defaultTimeZoneStr.substring(with: 0..<2))!+timezoneOffset
    var hour = ""
    if(convertedTime > 24){
        convertedTime = convertedTime - 24
    }
    
    if(convertedTime > 12){
        if(convertedTime == 24){
            hour = "12\(defaultTimeZoneStr.substring(with: 2..<5)) AM"
        }else{
            convertedTime = convertedTime % 12
            hour = "\(convertedTime)\(defaultTimeZoneStr.substring(with: 2..<5)) PM"
        }
    }else if(convertedTime == 12){
        hour = "12\(defaultTimeZoneStr.substring(with: 2..<5)) PM"
    }
    else{
        hour = "\(convertedTime)\(defaultTimeZoneStr.substring(with: 2..<5)) AM"
    }
  
    return "\(hour)"
}

func getOnlyHour(timezone: Int) -> Int {
    let currentDate = Date()

    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(secondsFromGMT:0)
    formatter.dateFormat = "HH:mma"
    let defaultTimeZoneStr = formatter.string(from: currentDate)
    let timezoneOffset = timezone / 3600
    var convertedTime = Int(defaultTimeZoneStr.substring(with: 0..<2))!+timezoneOffset
    var hour = ""
    if(convertedTime > 24){
        convertedTime = convertedTime - 24
    }
    
    return convertedTime
}



func timeStampFormat(timeStamp : Double) -> String {
    
    let date = NSDate(timeIntervalSince1970: timeStamp)
    
    let dayTimePeriodFormatter = DateFormatter()

    dayTimePeriodFormatter.dateFormat = "h:mm a"

    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}

func getTimeStringFromTimeStamp(timeStamp : Double) -> String {

        let date = NSDate(timeIntervalSince1970: timeStamp)
        
        let dayTimePeriodFormatter = DateFormatter()

        dayTimePeriodFormatter.dateFormat = "h:mma"

        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }

func getTimeNumFromTimeStamp(timeStamp : Double) -> String {

        let date = NSDate(timeIntervalSince1970: timeStamp)
        
        let dayTimePeriodFormatter = DateFormatter()

     // UnComment below to get only time
        dayTimePeriodFormatter.dateFormat = "HH:mm"

        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }

func getWeatherIconHour(id: Int) -> String {
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
        return "cloud.fill"
    case 801...804:
        return "smoke.fill"
    default:
        return "cloud.fill"

    }
}

func getWeatherIcon10Day(id: Int) -> String {
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


public struct WeatherForecastModel{
    var forecastList : [WeatherForecastNextHour]
    
    init(response: APIForecastWeather) {
        let currentTimezone = 7
        var list : [WeatherForecastNextHour] = []
        for index in 0..<response.list.count{
            var hour = ""
            var timeNum = 0
            var convertedTime = Int(response.list[index].dt_txt.substring(with: 11..<13))! + currentTimezone
            if(convertedTime > 24){
                convertedTime = convertedTime - 24
                timeNum = convertedTime
            }else{
                timeNum = convertedTime
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
            let icon = getWeatherIconHour(id: response.list[index].weather[0].id)
            list.append(WeatherForecastNextHour(time: time, temp: temp, icon: icon, timeNum: timeNum))
        }
        forecastList = list
    }
}

struct WeatherForecastNextHour{
    var time : String
    var temp : Int
    var icon : String
    var timeNum : Int
}

struct Weather10Day{
    var day : String
    var temp_min : Int
    var temp_max : Int
    var icon : String
}


public struct Weather10DayModel{
    var forecast10 : [Weather10Day]
    var highest_temp : Int = 0
    var lowest_temp : Int
    
    init(response: APIForecast10DayWeather){
        var low_temp = Int(response.list[0].temp.min)
        var list : [Weather10Day] = []
        for index in 0..<response.list.count{
            var day = "\(getDateFromTimeStamp(timeStamp: Double(response.list[index].dt)))"
            day = getDayOfWeek(day)!
            let temp_min = Int(response.list[index].temp.min)
            let temp_max = Int(response.list[index].temp.max)
            let icon = getWeatherIcon10Day(id: response.list[index].weather[0].id)
            if temp_max > highest_temp{
                highest_temp = temp_max
            }
            if temp_min < low_temp{
                low_temp = temp_min
            }
            
            list.append(Weather10Day(day: day, temp_min: temp_min, temp_max: temp_max, icon: icon))
        }
        forecast10 = list
        lowest_temp = low_temp
       
    }

    
}

func getDayOfWeek(_ today:String) -> String? {
    let formatter  = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let date = Date()
    let currentDate = formatter.string(from: date)
    guard let todayDate = formatter.date(from: today) else { return nil }
    if (currentDate == today){
        return "Today"
    }
    let myCalendar = Calendar(identifier: .gregorian)
    let weekDay = myCalendar.component(.weekday, from: todayDate)
    switch weekDay{
    case 1:
        return "Sun"
    case 2:
        return "Mon"
    case 3:
        return "Tue"
    case 4:
        return "Wed"
    case 5:
        return "Thu"
    case 6:
        return "Fri"
    case 7:
        return "Sat"
    default:
        return ""
    }

}

func getDateFromTimeStamp(timeStamp : Double) -> String {

        let date = NSDate(timeIntervalSince1970: timeStamp)
        
        let dayTimePeriodFormatter = DateFormatter()

     // UnComment below to get only time
        dayTimePeriodFormatter.dateFormat = "yyyy-MM-dd"

        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
