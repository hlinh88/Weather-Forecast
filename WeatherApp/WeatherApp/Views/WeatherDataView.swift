//
//  WeatherDataView.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 23/1/2023.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

struct WeatherDataView: View {
    @ObservedObject var data : OurData
    
    @ObservedObject var weatherViewModel : WeatherViewModel
    
    @ObservedObject var weatherForecastViewModel : WeatherForecastViewModel
    
    @ObservedObject var weather10DayViewModel : WeatherForecast10DayViewModel
    
    @State private var region = MKCoordinateRegion(
        center:  CLLocationCoordinate2D(
            latitude: 0,
            longitude: 0
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5
        )
    )
    
    private let timeInterval = Int(NSDate().timeIntervalSince1970)
    
    private let hours = (Calendar.current.component(.hour, from: Date()))
    
    
    var body: some View {
        VStack(spacing: 8){
            CustomStackView{
                Label{
                    Text("HOURLY FORECAST")
                        .font(.custom("HelveticaNeue-Medium", size: 13))
                        .foregroundColor(.white)
                        .opacity(0.7)
                    
                }
            icon:{
                Image(systemName: "clock")
                    .foregroundColor(.white)
                    .opacity(0.7)
            }
            .padding(.horizontal, 15)
            } contentView: {
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack(spacing: 15){
                        NowView(hours: hours, sunset: weatherViewModel.sunsetNum, sunrise: weatherViewModel.sunriseNum, icon: weatherViewModel.icon, temp: weatherViewModel.temp)
                        
                        ForEach(0..<weatherForecastViewModel.forecastList.count, id: \.self) { i in
                            let time = weatherForecastViewModel.forecastList[i].timeNum
                            let sunset = weatherViewModel.sunsetNum
                            let sunrise = weatherViewModel.sunriseNum
                            let icon = weatherForecastViewModel.forecastList[i].icon
                            
                            CloudView(time: time, sunset: sunset, sunrise: sunrise, icon: icon, timeDisplay: weatherForecastViewModel.forecastList[i].time, tempDisplay: weatherForecastViewModel.forecastList[i].temp)
                            
                            if(time == sunrise){
                                ForecastView(time: weatherViewModel.sunrise, celcius: "Sunrise", icon: "sunrise.fill")
                            }
                            
                            if(time == sunset){
                                ForecastView(time: weatherViewModel.sunset, celcius: "Sunset" , icon: "sunset.fill")
                            }
                            
                            
                        }
                    }
                }
            }
            
            CustomStackView {
                Label{
                    Text("10-DAY FORECAST")
                        .font(.custom("HelveticaNeue-Bold", size: 15))
                        .foregroundColor(.white)
                        .opacity(0.7)
                    
                }
            icon:{
                Image(systemName: "calendar")
                    .foregroundColor(.white)
                    .opacity(0.7)
            }
            .padding(.horizontal, 15)
            } contentView: {
                VStack(alignment: .leading, spacing: 10){
                    ForEach(0..<weather10DayViewModel.forecast10DayList.count, id: \.self) { index in
                        Forecast10DayView(day: weather10DayViewModel.forecast10DayList[index].day, icon: weather10DayViewModel.forecast10DayList[index].icon, temp_min: weather10DayViewModel.forecast10DayList[index].temp_min, temp_max: weather10DayViewModel.forecast10DayList[index].temp_max, highest_temp: weather10DayViewModel.highest_temp, lowest_temp: weather10DayViewModel.lowest_temp)
                    }
                    .frame(maxWidth: .infinity)
                }
                
            }
            
            
            CustomStackView {
                Label{
                    Text("PRECITIPATION")
                        .font(.custom("HelveticaNeue-Medium", size: 13))
                        .foregroundColor(.white)
                        .opacity(0.7)
                }
            icon:{
                Image(systemName: "umbrella.fill")
                    .foregroundColor(.white)
                    .opacity(0.7)
            }
            .padding(.horizontal, 15)
            } contentView: {
                ZStack{
                    Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                        .frame(maxWidth: .infinity)
                        .cornerRadius(12)
                    AsyncImage(url: URL(string: "https://maps.openweathermap.org/maps/2.0/weather/PA0/1/1/1?date=1675014519&appid=1602a19a43556d4a825f3b4fe5cdb3b5")){ image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        Color.gray.opacity(0.1)
                    }
                    .cornerRadius(12)
                    
                }
                .frame(maxWidth: .infinity)
                
            }
            
            HStack{
                CustomStackView {
                    Label{
                        Text("UV INDEX")
                            .font(.custom("HelveticaNeue-Medium", size: 13))
                            .foregroundColor(.white)
                            .opacity(0.7)
                        
                    }
                icon:{
                    Image(systemName: "sun.max.fill")
                        .foregroundColor(.white)
                        .opacity(0.7)
                }
                .padding(.horizontal, 15)
                } contentView: {
                    VStack(alignment: .leading){
                        Text("0")
                            .font(.custom("HelveticaNeue-Bold", size: 30))
                        Text("Low")
                            .font(.custom("HelveticaNeue-Bold", size: 20))
                        ZStack(alignment: .leading){
                            Capsule()
                                .fill(.linearGradient(.init(colors: [.cyan, .green, .yellow, .orange, .red, .purple]), startPoint: .leading, endPoint: .trailing))
                                .frame(maxWidth: .infinity)
                                .frame(height: 6)
                            Circle()
                                .fill()
                                .foregroundColor(.white)
                                .frame(height: 10)
                                
                        }
                        
                        Text("Low for the rest of the day.") 
                            .font(.custom("HelveticaNeue", size: 14))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .frame(maxHeight: .infinity)
                
                CustomStackView {
                    Label{
                        if(hours > weatherViewModel.sunriseNum){
                            Text("SUNRISE")
                                .font(.custom("HelveticaNeue-Medium", size: 13))
                                .foregroundColor(.white)
                                .opacity(0.7)
                            
                        }else if (hours > weatherViewModel.sunsetNum || hours < weatherViewModel.sunriseNum){
                            Text("SUNSET")
                                .font(.custom("HelveticaNeue-Medium", size: 13))
                                .foregroundColor(.white)
                                .opacity(0.7)
                        }
                        
                        
                    }
                icon:{
                    if(hours > weatherViewModel.sunriseNum){
                        Image(systemName: "sunrise.fill")
                            .foregroundColor(.white)
                            .opacity(0.7)
                        
                    }else if (hours > weatherViewModel.sunsetNum || hours < weatherViewModel.sunriseNum){
                        Image(systemName: "sunset.fill")
                            .foregroundColor(.white)
                            .opacity(0.7)
                    }
                    
                }
                .padding(.horizontal, 15)
                } contentView: {
                    VStack(alignment: .leading){
                        SunriseSunsetView(hours: hours, sunset: weatherViewModel.sunsetNum, sunrise: weatherViewModel.sunriseNum, sunriseText : weatherViewModel.sunrise, sunsetText : weatherViewModel.sunset )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .frame(maxHeight: .infinity)
                
            }
            
            
            
        }
    }
}

struct NowView : View {
    var hours : Int
    var sunset : Int
    var sunrise : Int
    var icon : String
    var temp : Int
    
    var body : some View {
        if((sunset <= hours && hours < 24 || hours >= 0 && hours < sunrise) && icon == "cloud.fill"){
            ForecastView(time: "Now", celcius: "\(temp)", icon: "cloud.moon.fill")
        }else if ((sunrise <= hours && hours <= sunset) && icon == "cloud.fill"){
            ForecastView(time: "Now", celcius: "\(temp)", icon: "cloud.sun.fill")
        }else{
            ForecastView(time: "Now", celcius: "\(temp)", icon: icon)
        }
    }
}

struct SunriseSunsetView : View {
    var hours : Int
    var sunset : Int
    var sunrise : Int
    var sunriseText : String
    var sunsetText : String
    
    var body : some View {
        
        if(hours > sunrise){
            Text(sunriseText)
                .font(.custom("HelveticaNeue-Bold", size: 25))
            Image(systemName: "sunrise.fill")
                .resizable()
                .scaledToFit()
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .yellow)
                .frame(width: 40, height: 40)
            Text("Sunset: \(sunsetText)")
                .font(.custom("HelveticaNeue", size: 15))
        }else if (hours > sunset || hours < sunrise){
            Text(sunsetText)
                .font(.custom("HelveticaNeue-Bold", size: 25))
            Image(systemName: "sunset.fill")
                .resizable()
                .scaledToFit()
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .yellow)
                .frame(width: 40, height: 40)
            Text("Sunrise: \(sunriseText)")
                .font(.custom("HelveticaNeue-Medium", size: 15))
        }
        
    }
}





struct CloudView : View {
    var time : Int
    var sunset: Int
    var sunrise: Int
    var icon : String
    var timeDisplay: String
    var tempDisplay : Int
    
    var body : some View {
        if(time <= sunset && time > sunrise && icon == "cloud.fill"){
            ForecastView(time: timeDisplay, celcius: "\(tempDisplay)", icon: "cloud.sun.fill")
        }else if(time > 0 && time <= sunrise && icon == "cloud.fill" || time > sunset && time <= 24 && icon == "cloud.fill"){
            ForecastView(time: timeDisplay, celcius: "\(tempDisplay)", icon: "cloud.moon.fill")
        }else{
            ForecastView(time: timeDisplay, celcius: "\(tempDisplay)", icon: icon)
        }
    }
}

struct ForecastView: View {
    var time : String
    var celcius : String
    var icon : String
    
    var body: some View {
        VStack(){
            Text(time)
                .font(.custom("HelveticaNeue-Medium", size: 13))
            if(icon.contains(find: "sunset") || icon.contains(find: "sunrise")){
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .yellow)
                    .frame(width: 25, height: 25)
            }
            else if(icon.contains(find: "cloud.sun")){
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .yellow)
                    .frame(width: 25, height: 25)
            }
            else if(icon.contains(find: "sun")){
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.yellow, .white)
                    .frame(width: 25, height: 25)
            }
            if(icon.contains(find: "cloud.rain") || icon.contains(find: "cloud.drizzle") || icon.contains(find: "cloud.snow")){
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .cyan)
                    .frame(width: 25, height: 25)
            }
            if(icon.contains(find: "cloud.fog") || icon.contains(find: "cloud.fill") || icon.contains(find: "cloud.moon.fill") || icon.contains(find: "smoke.fill")){
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white)
                    .frame(width: 25, height: 25)
            }
            if("\(celcius)" == "Sunrise" || "\(celcius)" == "Sunset"){
                Text("\(celcius)")
                    .font(.custom("HelveticaNeue", size: 20))
            }else{
                Text("\(celcius)°")
                    .font(.custom("HelveticaNeue", size: 20))
            }
            
        }
        .padding(.horizontal, 5)
    }
}

struct Forecast10DayView : View {
    var day : String
    var icon : String
    var temp_min : Int
    var temp_max : Int
    var highest_temp : Int
    var lowest_temp : Int
    
    var body: some View{
        HStack(spacing: 10){
            Text(day)
                .font(.custom("HelveticaNeue-Medium", size: 18))
                .frame(width: 60, alignment: .leading)
            if(icon.contains(find: "cloud.sun")){
                Image(systemName: icon)
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .yellow)
                    .frame(width: 30)
            }
            else if(icon.contains(find: "sun")){
                Image(systemName: icon)
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.yellow, .white)
                    .frame(width: 30)
            }
            if(icon.contains(find: "cloud.rain") || icon.contains(find: "cloud.drizzle") || icon.contains(find: "cloud.snow")){
                Image(systemName: icon)
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .cyan)
                    .frame(width: 30)
            }
            if(icon.contains(find: "cloud.fog") || icon.contains(find: "cloud.fill") || icon.contains(find: "cloud.moon.fill") || icon.contains(find: "smoke.fill")){
                Image(systemName: icon)
                    .symbolVariant(.fill)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white)
                    .frame(width: 30)
            }
            Text("\(temp_min)°")
                .font(.custom("HelveticaNeue-Medium", size: 18))
                .opacity(0.5)
            
            ZStack(alignment: .leading){
                Capsule()
                    .fill(.tertiary)
                    .foregroundColor(.white)
                
                GeometryReader{proxy in
                    
                    Capsule()
                        .fill(.linearGradient(.init(colors: [.cyan, .green, .yellow, .orange]), startPoint: .leading, endPoint: .trailing))
                    // set width based on temp max min ratio with highest lowest temp
                        .frame(width: (proxy.size.width / CGFloat((highest_temp - lowest_temp))) * CGFloat(temp_max - temp_min))
                    // padding left insets equalizer
                        .padding(.leading, (proxy.size.width / CGFloat((highest_temp - lowest_temp))) * CGFloat(temp_min - lowest_temp))
                    // padding right insets equalizer
                        .padding(.trailing, (proxy.size.width / CGFloat((highest_temp - lowest_temp))) * CGFloat(highest_temp - temp_max))
                    
                }
            }
            .frame(height: 6)
            
            Text("\(temp_max)°")
                .font(.custom("HelveticaNeue-Medium", size: 18))
            
        }
    }
    
    
    
}

