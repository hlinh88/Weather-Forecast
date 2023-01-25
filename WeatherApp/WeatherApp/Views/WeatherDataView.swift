//
//  WeatherDataView.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 23/1/2023.
//

import SwiftUI

struct WeatherDataView: View {
    @ObservedObject var data : OurData
    
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
                        ForEach(0..<data.forecastArray.count, id: \.self) { i in
                            ForecastView(time: data.forecastArray[i].time, celcius: data.forecastArray[i].temp, image: data.forecastArray[i].icon)
                           }
                    }
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
              Text("A map will be placed here")
                    .frame(maxWidth: .infinity)
                    .font(.custom("HelveticaNeue-Bold", size: 20))
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
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                }
                .frame(maxHeight: .infinity)
                
                CustomStackView {
                    Label{
                        Text("SUNRISE")
                            .font(.custom("HelveticaNeue-Medium", size: 13))
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
                .frame(maxHeight: .infinity)

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
                    ForEach(forecast){
                        cast in
                        HStack(spacing: 10){
                            Text(cast.day)
                                .font(.custom("HelveticaNeue-Medium", size: 18))
                                .frame(width: 60, alignment: .leading)
                            cast.image.contains(find: "cloud.sun") ?
                            Image(systemName: cast.image)
                                .symbolVariant(.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, .yellow)
                                .frame(width: 30)
                            :
                            Image(systemName: cast.image)
                                .symbolVariant(.fill)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.yellow, .white)
                                .frame(width: 30)
                            Text("\(Int(cast.celcius))")
                                .font(.custom("HelveticaNeue-Medium", size: 18))
                            
                            ZStack(alignment: .leading){
                                Capsule()
                                    .fill(.tertiary)
                                    .foregroundColor(.white)
                                
                                GeometryReader{proxy in
                                    Capsule()
                                        .fill(.linearGradient(.init(colors: [.cyan, .mint]), startPoint: .leading, endPoint: .trailing))
                                        .frame(width: (cast.celcius / 32) * proxy.size.width)
                                }
                            }
                            .frame(height: 6)
                            
                            Text("\(Int(cast.celcius) + 10)")
                                .font(.custom("HelveticaNeue-Medium", size: 18))
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
            }

        }
    }
}

struct ForecastView: View {
    var time : String
    var celcius : Int
    var image : String
    
    var body: some View {
        VStack(){
            Text(time)
                .font(.custom("HelveticaNeue-Medium", size: 13))
            image.contains(find: "sun") ?
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.yellow, .white)
                .frame(width: 25, height: 25)
            :
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white)
                .frame(width: 25, height: 25)
            Text("\(celcius)°")
                .font(.custom("HelveticaNeue", size: 20))
        }
        .padding(.horizontal, 5)
    }
}

struct WeatherDataView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(data: OurData())
    }
}


extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
