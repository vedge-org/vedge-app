//
//  TicketView.swift
//  Vedge
//
//  Created by 주현명 on 10/3/24.
//


import SwiftUI

struct TicketListView: View {
    
    @State private var currentPage: Int = 0
    @State private var offset: CGFloat = 0
    
    let cards = ["Sample","Sample2","Sample3","Sample4","Sample5"]
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 0) {
                VStack{
                    
                }.frame(minHeight: 48)
                GeometryReader { geometry in
                    let cardWidth = geometry.size.width - 32
                    let pageWidth = cardWidth + 8
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(0..<cards.count, id: \.self) { index in
                                Ticket(imageName: cards[index])
                                    .frame(width: cardWidth)
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
                .frame(maxHeight: 470)
                VStack(alignment: .leading, spacing: 10) {
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Constants.BackgroundBorder)
                        .frame(maxWidth: .infinity,maxHeight: 1)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            .padding(0)
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
        }
    }
    
    private func limitScrollOffset(_ offset: CGFloat, pageWidth: CGFloat, geometry: GeometryProxy) -> CGFloat {
        let minOffset = -CGFloat(cards.count - 1) * pageWidth
        let maxOffset: CGFloat = 0
        return min(max(offset, minOffset), maxOffset)
    }
}



#Preview {
    TicketListView()
}
