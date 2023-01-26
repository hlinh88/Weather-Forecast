//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 26/1/2023.
//


import SwiftUI

struct WeatherData : Decodable{
    let name : String
    let main : Main
    let weather : [Weather]
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

struct List : Decodable{
    let dt_txt : String
    let main : Main
    let weather : [Weather]
}



struct DataForecastNextHour : Decodable{
    let list : [List]
}
