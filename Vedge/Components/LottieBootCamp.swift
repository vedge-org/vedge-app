//
//  LottieBootCamp.swift
//  Vedge
//
//  Created by 주현명 on 10/8/24.
//

import Lottie
import SwiftUI

struct LottieBootCamp: View {
    var body: some View {
        LottieView(animation: .named("PhaseCheck"))
          .playing()
    }
}

#Preview {
    LottieBootCamp()
}
