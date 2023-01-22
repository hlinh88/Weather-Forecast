//
//  WeatherDataView.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 23/1/2023.
//

import SwiftUI

struct WeatherDataView: View {
    var body: some View {
        VStack(spacing: 8){
            CustomStackView{
                Label{
                    Text("HOURLY FORECAST")
                        .font(.custom("HelveticaNeue-Bold", size: 15))
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
            CustomStackView {
                Label{
                    Text("PRECITIPATION")
                        .font(.custom("HelveticaNeue-Bold", size: 15))
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
              Text("A map will be placed here")
                    .frame(maxWidth: .infinity)
                    .font(.custom("HelveticaNeue-Bold", size: 20))
            }
            
            HStack{
                CustomStackView {
                    Label{
                        Text("UV INDEX")
                            .font(.custom("HelveticaNeue-Bold", size: 15))
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
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .frame(height: .infinity)
                
                CustomStackView {
                    Label{
                        Text("SUNRISE")
                            .font(.custom("HelveticaNeue-Bold", size: 15))
                            .foregroundColor(.white)
                            .opacity(0.7)
                         
                    }
                    icon:{
                        Image(systemName: "sunrise.fill")
                            .foregroundColor(.white)
                            .opacity(0.7)
                    }
                    .padding(.horizontal, 15)
                } contentView: {
                    VStack(alignment: .leading){
                        Text("6:35 AM")
                            .font(.custom("HelveticaNeue-Bold", size: 20))
                        Text("Sunset: 5:41PM")
                            .font(.custom("HelveticaNeue-Bold", size: 15))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .frame(height: .infinity)

            }

        }
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
