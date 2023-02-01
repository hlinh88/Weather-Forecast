//
//  MyWeatherView.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 31/1/2023.
//

import SwiftUI

struct MyWeatherView: View {
    @Binding var text: String
    
    var background : String
    
    @ObservedObject var weatherViewModel : WeatherViewModel
    
    @ObservedObject var weatherForecastViewModel : WeatherForecastViewModel
    
    @ObservedObject var weather10DayViewModel : WeatherForecast10DayViewModel
    
    @State private var isEditing = false
    
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
                                .onTapGesture {
                                    self.isEditing = true
                                }
                            Spacer()
                            Image(systemName: "mic.fill")
                                .imageScale(.small)
                                .foregroundColor(.white)
                            
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

                      
                        
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 30)
        }
        .navigationBarBackButtonHidden(true)
       
    }
}

