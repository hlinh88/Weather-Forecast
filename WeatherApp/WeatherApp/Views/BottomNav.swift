//
//  BottomNav.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 30/1/2023.
//

import SwiftUI

struct BottomNav: View {
    var bg : String
    var body: some View {
        ZStack{
            Image(bg).resizable().edgesIgnoringSafeArea(.all)
            Blur(style: .regular).edgesIgnoringSafeArea(.all)
            HStack{
                Image(systemName: "map")
                    .imageScale(.large)
                Spacer()
                HStack{
                    Image(systemName: "location.fill")
                        .imageScale(.small)
                        .padding(.horizontal, 5)
                }
                Spacer()
                Image(systemName: "list.bullet")
                    .imageScale(.large)
            }
            .padding(.horizontal, 30)
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(height: 25, alignment: .bottom)
        .border(width: 1, edges: [.top], color: .white)
    }
}
