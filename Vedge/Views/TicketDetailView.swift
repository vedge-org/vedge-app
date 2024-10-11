//
//  TicketDetailView.swift
//  Vedge
//
//  Created by 주현명 on 10/3/24.
//

import SwiftUI
import CoreNFC

struct TicketDetailView: View {
    @StateObject private var nfcManager = NFCSessionManager()
    @State var showingNFCView = false
    @State private var dominantColor: Color = .black
    @State private var isNFCAvailable = NFCNDEFReaderSession.readingAvailable
    @State private var nfcMessage: String = "Tap 'Scan NFC' to start."
    
    var imageName = "Sample3"
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 10) {
                    Image("BackIcon")
                      .frame(width: 32, height: 20)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                .frame(height: 40, alignment: .leading)
                .background(Constants.BackgroundElevated)
                .cornerRadius(100)
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Image("ShareIcon")
                    .frame(width: 24, height: 24)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .frame(width: 40, height: 40, alignment: .leading)
                .background(Constants.BackgroundElevated)
                .cornerRadius(100)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
            VStack(alignment: .center, spacing: 8) {
                HStack(alignment: .top, spacing: 10) {
                      Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 353, height: 198.5626678466797)
                        .clipped()
                        .cornerRadius(12)
                }
                .padding(4)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(Constants.BackgroundWhite)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.16), radius: 8, x: 0, y: 8)
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 10) {
                        // Title/Accent
                        Text("YOASOBI ASIA TOUR 2024－2025 LIVE IN KOREA")
                            .lineLimit(2)
                            .typography(.title,accent: true,color:Constants.FixedContentsAccent)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Constants.BackgroundWhite)
                    .cornerRadius(12)
                    // 리코더 모양 디바이더
                    RecorderView().frame(height: 6)
                                    
                    VStack(alignment: .center, spacing: 10) {
                        VStack( spacing: 0) {
                            CustomText(text:"공연 장소",style:.caption, accent: false ,color:Constants.TextBlackNeutral)
                            CustomText(text:"성남아트센터 콘서트홀",style:.headline,accent: false ,color:Constants.TextBlackDefault)
                        }
                        .padding(0)
                        .frame(maxWidth: .infinity)
                        HStack(alignment: .center, spacing: 0) {
                            VStack(spacing: 0) {
                                // Caption/Default
                                CustomText(text:"일자",style:.caption, accent: false ,color:Constants.TextBlackNeutral)
                                CustomText(text:"24. 09. 30",
                                           style:.headline,accent: false ,color:Constants.TextBlackDefault)
                            }
                            .padding(0)
                            .frame(maxWidth: .infinity)
                            VStack(spacing: 0) {
                                // Caption/Default
                                CustomText(text:"시간",style:.caption, accent: false ,color:Constants.TextBlackNeutral)
                                CustomText(text:"00시 00분",style:.headline,accent: false ,color:Constants.TextBlackDefault)
                            }
                            .padding(0)
                            .frame(maxWidth: .infinity)
                        }
                        .padding(0)
                        .frame(maxWidth: .infinity)
                        HStack(alignment: .center, spacing: 0) {
                            VStack(alignment: .leading, spacing: 0) {
                                // Caption/Default
                                CustomText(text:"좌석",style:.caption, accent: false ,color:Constants.TextBlackNeutral)
                                CustomText(text:"85 D",style:.headline,accent: false ,color:Constants.TextBlackDefault)
                            }
                            .padding(0)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            VStack(alignment: .leading, spacing: 0) {
                                // Caption/Default
                                CustomText(text:"주문 번호",style:.caption, accent: false ,color:Constants.TextBlackNeutral)
                                CustomText(text:"CON-12345",style:.headline,accent: false ,color:Constants.TextBlackDefault)
                            }
                            .padding(0)
                            .frame(maxWidth: .infinity)
                        }
                        .padding(0)
                        .frame(maxWidth: .infinity)
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Constants.BackgroundWhite)
                    .cornerRadius(12)
                }
                .clipped()
                .shadow(color: .black.opacity(0.16), radius: 8, x: 0, y: 8)
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .top)

            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            SlideToUseView(showingNFCView: $showingNFCView,foregroundColor: $dominantColor)
        
        }.frame(maxWidth: .infinity, maxHeight: .infinity) // 전체 화면 차지
            .background(
                LinearGradient(
                stops: [
                    Gradient.Stop(color: .white, location: 0.00),
                    Gradient.Stop(color: dominantColor, location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
                )
            )
            .onAppear {
                // 주요 색상 추출 로직
                if let uiImage = UIImage(named: imageName), let color = uiImage.dominantColor() {
                    dominantColor = color
                }
            }
            .environmentObject(nfcManager)
    }
    

}

#Preview {
    TicketDetailView()
}
