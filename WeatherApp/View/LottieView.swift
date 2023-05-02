//
//  LottieView.swift
//  WeatherApp
//
//  Created by ahmed on 01/05/2023.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    
    var name : String
    var loopMode: LottieLoopMode = .loop
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> some UIView {
        let view = UIView()
        return view
    }
   
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {
        uiView.subviews.forEach ({$0.removeFromSuperview()})
        
        let animationView = AnimationView()
        uiView.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: uiView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: uiView.heightAnchor)
        ])
        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleToFill
        animationView.loopMode = loopMode
        animationView.play()
    }
}
