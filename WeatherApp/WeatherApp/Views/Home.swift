//
//  Home.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 22/1/2023.
//

import SwiftUI

struct Home: View {
    @State var offset : CGFloat = 0
    
    var topEdge : CGFloat
    
    var body: some View {
        ZStack{
            GeometryReader{proxy in
                Image("bg_day")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width,  height: proxy.size.height)
            }
            .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    VStack(alignment: .center, spacing: 5){
                        Text("Hanoi")
                            .font(.custom("HelveticaNeue-Medium", size: 35))
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                        
                        Text("18°")
                            .font(.custom("HelveticaNeue-Medium", size: 70))
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                        
                        Text("Mostly Sunny")
                            .font(.custom("HelveticaNeue-Medium", size: 20))
                            .foregroundStyle(.white)
                            .foregroundStyle(.secondary)
                            .shadow(radius: 5)
                            .opacity(getTitleOpacity())
                        
                        Text("H:25° L:13°")
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
                    
                    WeatherDataView()
                    
                    
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


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
