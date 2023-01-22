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
    
    @State var topOffset: CGFloat = 0
    @State var bottomOffset: CGFloat = 0
    
    init(@ViewBuilder titleView: @escaping ()->Title, @ViewBuilder contentView: @escaping ()->Content){
        self.contentView = contentView()
        self.titleView = titleView()
    }
    
    var body: some View{
        VStack(spacing: 0){
            titleView
                .font(.custom("HelveticaNeue-Bold", size: 15))
                .lineLimit(1)
                .frame(height: 38)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial, in:
                                CustomCorner(corners: bottomOffset < 38 ? .allCorners : [.topLeft, .topRight],
                                             radius: 12))
                .zIndex(1)
            
            VStack{
                contentView
                    .padding(.horizontal, 15)
                    .padding(.vertical, 15)
                    
            }
            .background(.ultraThinMaterial, in:
                CustomCorner(corners: [.bottomLeft, .bottomRight],
                             radius: 12))
            .offset(y: topOffset >= 190 ? 0 : -(-topOffset + 190))
            .zIndex(0)
            .clipped()
            .opacity(getOpacity())
        }
        .preferredColorScheme(.dark)
        .cornerRadius(12)
        .opacity(getOpacity())
        .offset(y: topOffset >= 190 ? 0 : -topOffset + 190)
        .background(
            GeometryReader{proxy -> Color in
                let minY = proxy.frame(in: .global).minY
                let maxY = proxy.frame(in: .global).maxY
                DispatchQueue.main.async {
                    self.topOffset = minY
                    self.bottomOffset = maxY - 190
                }
                return Color.clear
            }
        )
        .modifier(CornerModifier(bottomOffset: $bottomOffset))
    }
    
    
    func getOpacity()->CGFloat{
        if bottomOffset < 30{
            let progress = bottomOffset / 30
            return progress
        }
        return 1
    }
}

struct CornerModifier: ViewModifier{
    @Binding var bottomOffset: CGFloat
    
    func body(content: Content) -> some View {
        if bottomOffset < 38 {
            content
        }else{
            content.cornerRadius(12)
        }
    }
}

struct CustomStackView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
