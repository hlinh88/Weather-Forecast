//
//  Blur.swift
//  WeatherApp
//
//  Created by Hoang Linh Nguyen on 22/1/2023.
//

import Foundation
import SwiftUI
struct Blur: UIViewRepresentable{
    var style : UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView{
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
