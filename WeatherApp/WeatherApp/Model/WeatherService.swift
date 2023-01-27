//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 26/1/2023.
//

import SwiftUI
import CoreLocation

public final class WeatherService : NSObject{
    private let locationManager = CLLocationManager()
    private let API_KEY = "1602a19a43556d4a825f3b4fe5cdb3b5"
    private var completionHandler : ((WeatherModel) -> Void)?
    private var completionForecastHandler : ((WeatherForecastModel) -> Void)?
    
    var handlerWeatherExecuted = false
    var handlerForcastExecuted = false
    
    public override init(){
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping((WeatherModel) -> Void)){
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    public func loadForecastData(_ completionForecastHandler: @escaping((WeatherForecastModel) -> Void)){
        self.completionForecastHandler = completionForecastHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D){
        guard let weatherURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let weatherUrl = URL(string: weatherURL) else { return }
        
        if handlerWeatherExecuted == false {
            handlerWeatherExecuted = true
            URLSession.shared.dataTask(with: weatherUrl) { data, response, error in
                guard error == nil, let data = data else { return }
                if let response = try? JSONDecoder().decode(APICurrentWeather.self, from: data){
                    self.completionHandler?(WeatherModel(response: response))
                }
            }
            .resume()
        }
    }
    private func makeDataRequestForecast(forCoordinates coordinates: CLLocationCoordinate2D){
        guard let forecastURL = "https://pro.openweathermap.org/data/2.5/forecast/hourly?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&cnt=24&appid=\(API_KEY)&units=metric"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let forecastUrl = URL(string: forecastURL) else { return }
        if handlerForcastExecuted == false {
            handlerForcastExecuted = true
            URLSession.shared.dataTask(with: forecastUrl) { data, response, error in
                guard error == nil, let data = data else { return }
                if let response = try? JSONDecoder().decode(APIForecastWeather.self, from: data){
                    self.completionForecastHandler?(WeatherForecastModel(response: response))
                }
            }
            .resume()
        }
       
    }
   
}


extension WeatherService : CLLocationManagerDelegate {
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ){
        guard let location = locations.first else { return }
        makeDataRequest(forCoordinates: location.coordinate)
        makeDataRequestForecast(forCoordinates: location.coordinate)
    }
    
    public func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ){
        print(error.localizedDescription)
    }
}


struct APICurrentWeather : Decodable{
    let name : String
    let main : Main
    let weather : [Weather]
    let sys : Sys
}

struct Main : Decodable {
    let temp : Double
    let temp_min : Double
    let temp_max : Double
}

struct Weather : Decodable{
    let id : Int
    let main : String
    let description : String
}

struct Sys : Decodable{
    let sunrise : Int
    let sunset : Int
}

struct List : Decodable{
    let dt_txt : String
    let main : Main
    let weather : [Weather]
}

struct APIForecastWeather : Decodable{
    let list : [List]
}