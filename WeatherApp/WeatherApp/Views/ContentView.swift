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
