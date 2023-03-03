// Created by Alkın Çakıralar for ExpeditionEarth in 2.03.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let lottieFile: String

    let animationView = LottieAnimationView()

    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)

        animationView.animation = .named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.play()

        view.addSubview(animationView)

        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
}
