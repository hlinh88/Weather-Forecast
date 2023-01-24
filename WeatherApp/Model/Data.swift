//
//  Data.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 24/1/2023.
//

import SwiftUI

class OurData : ObservableObject {
    @Published public var weatherModel = WeatherModel(cityName: "", temp: 0, icon: "", weatherCondition: "", temp_min: 0, temp_max: 0)


    private var lat : Float = 21.027763
    private var lon : Float = 105.834160
    private var apiKey : String = "1602a19a43556d4a825f3b4fe5cdb3b5"
    
    func fetchWeather(){
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
                        let weatherCondition = decodedData.weather[0].main
                        let cityName = decodedData.name
                        let icon = self.getWeatherIcon(id: id)
                        let temp_min = Int(decodedData.main.temp_min.rounded())
                        let temp_max = Int(decodedData.main.temp_max.rounded())
                        self.weatherModel = WeatherModel(cityName: cityName, temp: temp, icon: icon, weatherCondition: weatherCondition, temp_min: temp_min, temp_max: temp_max)
                        print(self.weatherModel)
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
            return "cloud.bolt.fill"
        default:
            return "cloud.fill"
  
        }
    }
}


