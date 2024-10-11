//
//  RecorderView.swift
//  Vedge
//
//  Created by 주현명 on 10/3/24.
//

import SwiftUI

struct RecorderView: View {
    var body: some View {
        ZStack {
            HStack {
                Rectangle()
                    .frame(width: 6, height: 6)
                    .blendMode(.destinationOut)
                    .cornerRadius(10, corners: [.topRight, .bottomRight])
                Spacer()
                Rectangle()
                    .frame(width: 6, height: 6)
                    .blendMode(.destinationOut)
                    .cornerRadius(10, corners: [.topLeft, .bottomLeft])
            }
            
            HStack(spacing: 6) {
                ForEach(0..<25) { _ in
                    Rectangle()
                        .frame(width: 6, height: 2)
                        .cornerRadius(2)
                }
            }
            .blendMode(.destinationOut)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .padding(.horizontal, 24)
        .compositingGroup()
        }
    }
