// Created by Alkın Çakıralar for ExpeditionEarth in 28.02.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import SwiftUI

@main
struct ExpeditionEarthApp: App {
    init() {
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "Mohave-Medium", size: 25)!]
    }
    
    var body: some Scene {
        WindowGroup {
            IntroView()
        }
    }
}
