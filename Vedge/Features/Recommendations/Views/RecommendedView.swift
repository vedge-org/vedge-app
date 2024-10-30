//
//  RecommendedView.swift
//  Vedge
//
//  Created by 주현명 on 10/12/24.
//

import SwiftUI

struct RecommendedView: View {
    @State private var currentPage: Int = 0
    @State private var offset: CGFloat = 0
    
    let columns = [
        GridItem(.flexible(), spacing: 12),  // 열 사이 간격을 12로 설정
        GridItem(.flexible(), spacing: 12)
    ]
    
    let cards = [
        CardInfo(text: "요네즈 켄시 2번째\n내한공연 안내", color: Color(red: 0.9, green: 0.4, blue: 0.3)),
        CardInfo(text: "두 번째 카드", color: .blue),
        CardInfo(text: "세 번째 카드", color: .green)
    ]
    
    let eventItmes = ["Sample","Sample2","Sample3","Sample4","Sample5"]
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 32) {  // 컨텐츠 사이의 간격 추가
                GeometryReader { geometry in
                    let cardWidth = geometry.size.width - 32
                    let pageWidth = cardWidth + 8
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(0..<cards.count, id: \.self) { index in
                                CardView(cardInfo: cards[index])
                                    .frame(width: cardWidth, height: 361)
                            }
                        }
                        .padding(16)
                    }
                    .content.offset(x: limitScrollOffset(offset, pageWidth: pageWidth, geometry: geometry))
                    .scrollDisabled(true)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                offset = limitScrollOffset(-CGFloat(currentPage) * pageWidth + value.translation.width, pageWidth: pageWidth, geometry: geometry)
                            }
                            .onEnded { value in
                                let predictedEndOffset = -CGFloat(currentPage) * pageWidth + value.predictedEndTranslation.width
                                let predictedPage = -predictedEndOffset / pageWidth
                                
                                let targetPage: Int
                                if abs(value.translation.width) > pageWidth * 0.3 || abs(value.predictedEndTranslation.width) > pageWidth * 0.3 {
                                    targetPage = min(max(Int(predictedPage.rounded()), 0), cards.count - 1)
                                } else {
                                    targetPage = currentPage
                                }
                                
                                withAnimation(.interpolatingSpring(stiffness: 300, damping: 30)) {
                                    currentPage = targetPage
                                    offset = -CGFloat(currentPage) * pageWidth
                                }
                            }
                    )
                }
                .frame(height: 400)  // GeometryReader에 명시적인 높이 지정
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("공연 장소")
                        .typography(.headline, accent: true, color:Color.black)
                    LazyVGrid(columns: columns, spacing: 24) {
                        ForEach(0..<eventItmes.count, id: \.self) { index in
                            EventItemView(imageName: eventItmes[index])
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
    }
    
    private func limitScrollOffset(_ offset: CGFloat, pageWidth: CGFloat, geometry: GeometryProxy) -> CGFloat {
        let minOffset = -CGFloat(cards.count - 1) * pageWidth
        let maxOffset: CGFloat = 0
        return min(max(offset, minOffset), maxOffset)
    }
}


struct CardInfo {
    let text: String
    let color: Color
}

struct CardView: View {
    let cardInfo: CardInfo
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {  // 정렬을 왼쪽 아래로 설정
            cardInfo.color
            
            VStack(alignment: .leading, spacing: 8) {  // 텍스트를 세로로 정렬하고 간격 추가
                Text(cardInfo.text)
                    .typography(.title,accent: true,color:Constants.VariableContentsAccent)
            }
            .padding(.horizontal, 20)  // 좌우 패딩 20
            .padding(.vertical, 24)    // 상하 패딩 24
        }
        .cornerRadius(8)
    }
}

struct Event {
    var title: String
    var date: String
}

struct EventItemView: View {
    let imageName: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(imageName)
                .resizable()
                .frame(height: 232)
                .clipped()
                .cornerRadius(4)
            VStack(alignment: .leading, spacing: 0) {
                Text("콜드플레이 내한공연").typography(.body, accent: true ,color:Color.black)
                Text("24. 10. 04 ~ 24. 10. 06").typography(.caption, accent: false ,color:Constants.ContentsDefaultQuaternary)
                Text("올림픽공원 올림픽홀").typography(.caption, accent: false ,color:Constants.ContentsDefaultQuaternary)
            }
        }
    }
}

#Preview {
    RecommendedView()
}
