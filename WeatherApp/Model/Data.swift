//
//  Data.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 24/1/2023.
//

import SwiftUI

class OurData : ObservableObject {
    @Published public var weatherModel = WeatherModel(cityName: "", temp: 0, icon: "", weatherCondition: "", temp_min: 0, temp_max: 0)
    @Published public var forecastArray = [WeatherForecastNextHour]()
    
    private var lat : Float = -37.813629
    private var lon : Float = 144.963058
    private var apiKey : String = "1602a19a43556d4a825f3b4fe5cdb3b5"
    
    func fetchCurrentWeather(){
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
        if let url = URL(string: weatherURL){
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: url){ (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    do{
                        let decodedData = try JSONDecoder().decode(WeatherData.self, from: safeData)
                        let id = decodedData.weather[0].id
                        let temp = Int(decodedData.main.temp.rounded())
                        let weatherCondition = decodedData.weather[0].description.capitalized
                        let cityName = decodedData.name
                        let icon = self.getWeatherIcon(id: id)
                        let temp_min = Int(decodedData.main.temp_min.rounded())
                        let temp_max = Int(decodedData.main.temp_max.rounded())
                        DispatchQueue.main.async{
                            self.weatherModel = WeatherModel(cityName: cityName, temp: temp, icon: icon, weatherCondition: weatherCondition, temp_min: temp_min, temp_max: temp_max)
                        }
                       
                    } catch{
                        print(error)
                    }
                }
                
            }.resume()
        }
    }
    
    func fetchNextHourWeather(){
        let currentTimezone = 7
        let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&cnt=8&appid=\(apiKey)&units=metric"
        if let url = URL(string: weatherURL){
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: url){ (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    do{
                        let decodedData = try JSONDecoder().decode(DataForecastNextHour.self, from: safeData)
                        for index in 0..<decodedData.list.count{
                            var hour = ""
                            var time = Int(decodedData.list[index].dt_txt.substring(with: 11..<13))! + currentTimezone
                            if(time > 24){
                                time = time - 24
                            }
                            if(time > 12){
                                time = time % 12
                                hour = "\(time)PM"
                            }else{
                                hour = "\(time)AM"
                            }
                            let temp = Int(decodedData.list[index].main.temp.rounded())
                            let icon = self.getWeatherIcon(id: decodedData.list[index].weather[0].id)
                            DispatchQueue.main.async{
                                self.forecastArray.append(WeatherForecastNextHour(time: hour, temp: temp, icon: icon))
                            }
                        }
                       
                    } catch{
                        print(error)
                    }
                }
                
            }.resume()
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
}


struct WeatherModel {
    var cityName : String
    var temp : Int
    var icon: String
    var weatherCondition: String
    var temp_min: Int
    var temp_max: Int
}

struct WeatherForecastNextHour{
    var time : String
    var temp : Int
    var icon : String
}


extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func contains(find: String) -> Bool{
            return self.range(of: find) != nil
        }
}
