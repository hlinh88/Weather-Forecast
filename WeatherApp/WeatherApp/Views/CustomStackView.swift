//
//  CustomStackView.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 22/1/2023.
//

import SwiftUI

struct CustomStackView<Title: View, Content: View>: View {
    var titleView : Title
    var contentView : Content
    
    init(@ViewBuilder titleView: @escaping ()->Title, @ViewBuilder contentView: @escaping ()->Content){
        self.contentView = contentView()
        self.titleView = titleView()
    }
    
    var body: some View{
        VStack(spacing: 0){
            titleView
            
        }
    }
    
}

struct CustomStackView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
