// Created by Alkın Çakıralar for ExpeditionEarth in 28.02.2023
// Using Swift 5.0
// You can contact me with a.cakiralar@gmail.com
// Follow me on https://medium.com/@acakiralar
// Send friend request on https://www.linkedin.com/in/alkincakiralar/ 

import SwiftUI

extension Font {
    enum MohaveFont {
        case semibold
        case medium
        case custom(String)
        
        var value: String {
            switch self {
            case .semibold:
                return "Mohave-Semibold"
                
            case .medium:
                return "Mohave-Medium"
                
            case .custom(let name):
                return name
            }
        }
    }
    
    static func mohave(_ type: MohaveFont, size: CGFloat = 26) -> Font {
        return .custom(type.value, size: size)
    }
}
