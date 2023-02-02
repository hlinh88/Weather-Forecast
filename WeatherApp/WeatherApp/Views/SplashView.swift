//
//  SplashView.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 31/1/2023.
//

import SwiftUI



struct SplashView: View {
    @State private var isActive = false
    
    let weatherViewModel = WeatherViewModel(weatherService: WeatherService())
    let weatherForecastViewModel = WeatherForecastViewModel(weatherService: WeatherService())
    let weather10DayViewModel = WeatherForecast10DayViewModel(weatherService: WeatherService())
    
    var body: some View {
        
        if isActive{
            ContentView(weatherViewModel: weatherViewModel, weatherForecastViewModel: weatherForecastViewModel, weather10DayViewModel: weather10DayViewModel)
        }else{
            GeometryReader{proxy in
                ZStack{
                    Image("bg_default")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: proxy.size.width,  height: proxy.size.height)
                    VStack(spacing: 20) {
                        Image("splash").resizable().frame(width: 170, height: 170, alignment: .center).clipped().cornerRadius(20).shadow(radius: 10)
                        Text("Weather App").font(.custom("HelveticaNeue-Bold", size: 35)).foregroundColor(.white)
                    }.onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                            self.isActive = true
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.vertical)
           
        }
        
        
    }
    
}
