//
//  ContentView.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 20/1/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack{
            GeometryReader{proxy in
                Image("bg_day")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width,  height: proxy.size.height)
            }
            .ignoresSafeArea()
//            .overlay(.ultraThinMaterial)
            
            MainView()
        }
       
    }
}

struct MainView : View {
    var body: some View{
        ScrollView(.vertical, showsIndicators: false){
            VStack{
                VStack(alignment: .center, spacing: 5){
                    Text("Hanoi")
                        .font(.custom("HelveticaNeue-Medium", size: 35))
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                    
                    Text("24°")
                        .font(.custom("HelveticaNeue-Medium", size: 70))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                    
                    Text("Mostly Sunny")
                        .font(.custom("HelveticaNeue-Medium", size: 20))
                        .foregroundStyle(.white)
                        .foregroundStyle(.secondary)
                        .shadow(radius: 5)
                    
                    Text("H:25° L:13°")
                        .font(.custom("HelveticaNeue-Medium", size: 20))
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                        .foregroundStyle(.primary)
                }
                
                VStack(spacing: 8){
                    CustomStackView{
                        Label{
                            Text("Hourly Forecast")
                                .font(.custom("HelveticaNeue-Medium", size: 15))
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
                                ForEach(1...10, id: \.self) { i in
                                    ForecastView(time: "12PM", celcius: 18, image: "cloud.moon.fill")
                                   }
                            }
                        }
                    }
                }
                
            }
            .padding(.top, 25)
            .padding([.horizontal, .bottom])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ForecastView: View {
    var time : String
    var celcius : CGFloat
    var image : String
    
    var body: some View {
        VStack(){
            Text(time)
                .font(.custom("HelveticaNeue-Bold", size: 15))
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
            Text("\(Int(celcius))°")
                .font(.custom("HelveticaNeue-Bold", size: 20))
        }
        .padding(.horizontal, 5)
    }
}
