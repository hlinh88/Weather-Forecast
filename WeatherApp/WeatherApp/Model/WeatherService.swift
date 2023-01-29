//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 26/1/2023.
//

import SwiftUI
import CoreLocation
import MapKit

public final class WeatherService : NSObject, ObservableObject{
    private let locationManager = CLLocationManager()
    private let API_KEY = "1602a19a43556d4a825f3b4fe5cdb3b5"
    private var completionHandler : ((WeatherModel) -> Void)?
    private var completionForecastHandler : ((WeatherForecastModel) -> Void)?
    private var completionForecast10DayHandler : ((Weather10DayModel) -> Void)?

    
    var handlerWeatherExecuted = false
    var handlerForcastExecuted = false
    var handlerForecast10DayExecuted = false
    
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
    
    public func loadForecast10DayData(_ completionForecast10DayHandler: @escaping((Weather10DayModel) -> Void)){
        self.completionForecast10DayHandler = completionForecast10DayHandler
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
    
    private func makeDataRequestForecast10Day(forCoordinates coordinates: CLLocationCoordinate2D){
        guard let forecast10DayURL = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&cnt=10&appid=\(API_KEY)&units=metric"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let forecast10DayUrl = URL(string: forecast10DayURL) else { return }
        if handlerForecast10DayExecuted == false {
            handlerForecast10DayExecuted = true
            URLSession.shared.dataTask(with: forecast10DayUrl) { data, response, error in
                guard error == nil, let data = data else { return }
                if let response = try? JSONDecoder().decode(APIForecast10DayWeather.self, from: data){
                    self.completionForecast10DayHandler?(Weather10DayModel(response: response))
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
        makeDataRequestForecast10Day(forCoordinates: location.coordinate)
        
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

struct Temp : Decodable{
    let day : Double
    let min : Double
    let max : Double
}

struct List : Decodable{
    let dt_txt : String
    let main : Main
    let weather : [Weather]
}

struct List10Day : Decodable{
    let dt : Int
    let temp : Temp
    let weather : [Weather]
}



struct APIForecastWeather : Decodable{
    let list : [List]
}

struct APIForecast10DayWeather : Decodable{
    let list : [List10Day]
}
