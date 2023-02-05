//
//  MyWeatherView.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 31/1/2023.
//

import SwiftUI
import Combine

struct MyWeatherView: View {
    @State private var text: String = ""
    
    var background : String
    
    @ObservedObject var weatherViewModel : WeatherViewModel
    
    @ObservedObject var weatherForecastViewModel : WeatherForecastViewModel
    
    @ObservedObject var weather10DayViewModel : WeatherForecast10DayViewModel
    
    @ObservedObject private var weatherCityViewModel = WeatherCityViewModel(weatherService: WeatherService())
    
    @State private var isEditing = false
    
    private let date  = Date()
    
    var body: some View {
        NavigationView{
            GeometryReader{proxy in
                VStack{
                    Text("Weather")
                        .font(.custom("HelveticaNeue-Bold", size: 30))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .imageScale(.small)
                                .foregroundColor(.white)
                            TextField("Search for a city or airport", text: $text)
                                .font(.custom("HelveticaNeue", size: 15))
                                .padding(.vertical, 10)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    self.isEditing = true
                                }
                                .onSubmit {
                                    print(text)
                                    weatherCityViewModel.fetchDataByCityName(cityName: text)
                                    self.isEditing = false
                                    self.text = ""
                                }
                                   
                            Spacer()
                            if isEditing{
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.small)
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        self.text = ""
                                    }
                            }
                           
                            
                        }
                        .padding(.horizontal, 10)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color(.systemGray6)))
                        
                        if isEditing {
                            Button(action: {
                                self.isEditing = false
                                self.text = ""
                                UIApplication.shared.endEditing()
                            }) {
                                Text("Cancel")
                                    .font(.custom("HelveticaNeue", size: 15))
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing, 10)
                            .transition(.move(edge: .trailing))
                            .animation(.easeOut(duration: 5), value: isEditing)
                        }
                    }
                    .padding(.bottom, 20)
                    ScrollView(showsIndicators: false){
                        NavigationLink {
                            ContentView(weatherViewModel: weatherViewModel, weatherForecastViewModel: weatherForecastViewModel, weather10DayViewModel: weather10DayViewModel)
                        } label: {
                            ZStack{
                                GeometryReader{proxy in
                                    Image(background)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: proxy.size.width,  height: proxy.size.height)
                                    VStack{
                                        HStack{
                                            VStack{
                                                Text("My Location")
                                                    .font(.custom("HelveticaNeue-Bold", size: 25))
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .foregroundColor(.white)
                                                Text("\(weatherViewModel.cityName)")
                                                    .font(.custom("HelveticaNeue-Medium", size: 15))
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .foregroundColor(.white)
                                            }
                                        
                                            Spacer()
                                            Text("\(weatherViewModel.temp)°")
                                                .font(.custom("HelveticaNeue-Bold", size: 50))
                                                .foregroundColor(.white)
                                            
                                        }
                                        .padding(10)
                                        Spacer()
                                        HStack{
                                            Text("\(weatherViewModel.weatherCondition)")
                                                .font(.custom("HelveticaNeue-Medium", size: 15))
                                                .foregroundColor(.white)
                                            Spacer()
                                            Text("H:\(weatherViewModel.temp_max)° L:\(weatherViewModel.temp_min)°")
                                                .font(.custom("HelveticaNeue-Medium", size: 15))
                                                .foregroundColor(.white)
                                        }
                                        .padding(10)
                                       
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 150)
                            .cornerRadius(15)
                        }
                        .padding(.bottom, 5)
                        
                        ForEach(weatherCityViewModel.cityList, id: \.self) { city in
                            ItemView(cityName: city.cityName, temp: city.temp, weatherCondition: city.weatherCondition, temp_max: city.temp_max, temp_min: city.temp_min, time: city.time, timezone: city.timezone)
                           }
                      
                        
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
        }
        .navigationBarBackButtonHidden(true)
       
    }
}

struct ItemView : View {
    var cityName : String
    var temp : Int
    var weatherCondition : String
    var temp_max : Int
    var temp_min : Int
    var time : String
    var timezone: String
    
    var body: some View{
        ZStack{
            GeometryReader{proxy in
                Image(getBackground(hour: Int(timezone.substring(with: 0..<2))!))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width,  height: proxy.size.height)
                VStack{
                    HStack{
                        VStack{
                            Text(cityName)
                                .font(.custom("HelveticaNeue-Bold", size: 25))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.white)
                            Text(timezone)
                                .font(.custom("HelveticaNeue-Medium", size: 15))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        Text("\(temp)°")
                            .font(.custom("HelveticaNeue-Bold", size: 50))
                            .foregroundColor(.white)
                        
                    }
                    .padding(10)
                    Spacer()
                    HStack{
                        Text(weatherCondition)
                            .font(.custom("HelveticaNeue-Medium", size: 15))
                            .foregroundColor(.white)
                        Spacer()
                        Text("H:\(temp_max)° L:\(temp_min)°")
                            .font(.custom("HelveticaNeue-Medium", size: 15))
                            .foregroundColor(.white)
                    }
                    .padding(10)
                    
                    
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .cornerRadius(15)
        .padding(.vertical, 5)
    }
    
    func getBackground(hour: Int) -> String{
        switch hour{
        case 0...6:
            return "bg_latenight"
        case 6...12:
            return "bg_day"
        case 12...17:
            return "bg_afternoon"
        case 17...19:
            return "bg_lateafter"
        case 19...24:
            return "bg_night"
        default:
            return "bg_default"
        }
    }
    
}

