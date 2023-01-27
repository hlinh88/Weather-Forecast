//
//  Home.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 22/1/2023.
//

import SwiftUI


struct Home: View {
    @State var offset : CGFloat = 0
    
    @State var currentBackground = "bg_default"
    
    @ObservedObject var data : OurData
    
    @ObservedObject var weatherViewModel : WeatherViewModel
    
    @ObservedObject var weatherForecastViewModel : WeatherForecastViewModel
    
    @ObservedObject var weather10DayViewModel : WeatherForecast10DayViewModel
    
    var topEdge : CGFloat
    
    var body: some View {
        ZStack{
            GeometryReader{proxy in
                Image(currentBackground)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width,  height: proxy.size.height)
            }
            .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    VStack(alignment: .center, spacing: 5){
                        Text(weatherViewModel.cityName)
                            .font(.custom("HelveticaNeue-Medium", size: 35))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                        
                        Text("\(weatherViewModel.temp)°")
                            .font(.custom("HelveticaNeue-Medium", size: 70))
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                        
                        Text(weatherViewModel.weatherCondition)
                            .font(.custom("HelveticaNeue-Medium", size: 20))
                            .foregroundStyle(.white)
                            .foregroundStyle(.secondary)
                            .shadow(radius: 5)
                            .opacity(getTitleOpacity())
                        
                        Text("H:\(weatherViewModel.temp_max)° L:\(weatherViewModel.temp_min)°")
                            .font(.custom("HelveticaNeue-Medium", size: 20))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .foregroundStyle(.primary)
                            .opacity(getTitleOpacity())
                    }
                    .offset(y: -offset)
                    // Bottom drag effect
                    .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                    .offset(y: getTitleOffset())
                    
                    WeatherDataView(data: data, weatherViewModel: weatherViewModel, weatherForecastViewModel: weatherForecastViewModel, weather10DayViewModel: weather10DayViewModel)
                    
                    
                }
                .padding(.top, 25)
                .padding(.top, topEdge)
                .padding([.horizontal, .bottom])
                .overlay(
                    GeometryReader{proxy -> Color in
                        
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            self.offset = minY
                        }
                            
                        return Color.clear
                    }
                )
            }
        }
        .onAppear{
            weatherViewModel.fetchData()
            weatherForecastViewModel.fetchData()
            weather10DayViewModel.fetchData()
            let hour = Calendar.current.component(.hour, from: Date())
            getBackground(hour: hour)
        }

       
    }
    
    func getTitleOpacity()->CGFloat{
        let titleOffset = -getTitleOffset()
        
        let progress = titleOffset / 20
        
        let opacity = 1 - progress
        
        return opacity
    }
    
    func getTitleOffset()->CGFloat{
        if offset < 0 {
            let progress = -offset / 120
            
            let newOffset = (progress < 1.0 ? progress : 1) * 20
            
            return -newOffset
        }
        return 0
    }
    
    func getBackground(hour: Int){
        switch hour{
        case 0...6:
            currentBackground = "bg_latenight"
        case 6...12:
            currentBackground = "bg_day"
        case 12...17:
            currentBackground = "bg_afternoon"
        case 17...19:
            currentBackground = "bg_lateafter"
        case 19...24:
            currentBackground = "bg_night"
        default:
            currentBackground = "bg_default"
        }
        
    }
}

