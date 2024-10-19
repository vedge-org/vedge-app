//
//  Ticket.swift
//  Vedge
//
//  Created by 주현명 on 10/15/24.
//

import SwiftUI

struct Ticket: View {
    
    let imageName: String
    @State private var dominantColor: Color = .black
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 10) {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame( height: 198.5626678466797)
                    .clipped()
                    .cornerRadius(12)
            }
            .padding(4)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(dominantColor)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.16), radius: 8, x: 0, y: 8)
            RecorderViewV2(color: dominantColor).frame(height: 6)
            VStack(alignment: .center, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("LIVE NATION PRESENTS COLDPLAY : MUSIC OF THE SPHERES DELIVERED BY DHL").typography(.title, accent: true ,color:Constants.VariableContentsAccent)
                        .lineLimit(2)
                    HStack(alignment: .center, spacing: 0) {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("일자").typography(.caption, accent: false ,color:Constants.VariableContentsAlternative)
                            Text("25. 04. 16").typography(.body, accent: false ,color:Constants.VariableContentsDefault)
                                .frame(height: 26.0)
                        }
                        .padding(0)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
    
                        VStack(alignment: .leading, spacing: 0) {
                            Text("일자").typography(.caption, accent: false ,color:Constants.VariableContentsAlternative)
                            Text("25. 04. 16").typography(.body, accent: false ,color:Constants.VariableContentsDefault)
                        }
                        .padding(0)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("일자").typography(.caption, accent: false ,color:Constants.VariableContentsAlternative)
                            Text("25. 04. 16").typography(.body, accent: false ,color:Constants.VariableContentsDefault)
                        }
                        .padding(0)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                NavigationLink(destination: TicketDetailView(imageName: imageName)) {
                    Text("상세 보기")
                        .typography(.label,accent: true,color: Constants.FixedContentsAccent)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, minHeight: 52, maxHeight: 52, alignment: .center)
                .background(Constants.FixedBackgoundWhite)
                .cornerRadius(8)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(dominantColor)
            .cornerRadius(16)
        }
        .padding(0)
        .shadow(color: .black.opacity(0.16), radius: 8, x: 0, y: 8)
        .onAppear {
            if let uiImage = UIImage(named: imageName), let color = uiImage.dominantColor() {
                dominantColor = color
            }
        }
    }
}


struct RecorderViewV2: View {
    let color: Color
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
        .background(color)
        .padding(.horizontal, 20)
        .compositingGroup()
    }
}


#Preview {
    Ticket(imageName: "Sample")
}
