//
//  LottieColorValue.swift
//  Vedge
//
//  Created by 주현명 on 10/8/24.
//

import Lottie
import SwiftUI

extension Color {
    var lottieColorValue: LottieColor {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return LottieColor(r: Double(red), g: Double(green), b: Double(blue), a: Double(alpha))
    }
}
