//
//  ContentView.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 20/1/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var data : OurData
    var body: some View {
        GeometryReader{proxy in
            let topEdge = proxy.safeAreaInsets.top
            Home(data: data, topEdge: topEdge)
                .ignoresSafeArea(.all, edges: .top)
        }
       
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(data: OurData())
    }
}

