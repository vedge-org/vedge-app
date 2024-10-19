//
//  BottomNavigationBar.swift
//  Vedge
//
//  Created by 주현명 on 10/3/24.
//

import SwiftUI

struct BottomNavigationBar: View {
    @Binding var selectedTab: Tab
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Button {
                        withAnimation(.spring()) {
                            selectedTab = tab
                        }
                    } label: {
                        if tab == selectedTab {
                            VStack(alignment: .center, spacing: 2) {
                                Image(tab.iconName)
                                    .symbolRenderingMode(.monochrome)
                                    .renderingMode(.template)
                                    .foregroundStyle(.white)
                                Text(tab.rawValue)
                                    .font(
                                        Font.custom("Interop", size: 12)
                                            .weight(.medium)
                                    )
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal, 0)
                            .padding(.top, 4)
                            .padding(.bottom, 8)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(Constants.FixedContentsAccent)
                            .cornerRadius(45)
                        } else {
                            HStack(alignment: .center, spacing: 4) {
                                Image(tab.iconName)
                                    .frame(width: 28, height: 28)
                                    .foregroundStyle(Constants.ContentsStatusUnselected)
                            }
                            .padding(.horizontal, 8)
                            .padding(.top, 6)
                            .padding(.bottom, 8)
                            .frame(maxWidth: .infinity,  alignment: .center)
                            .cornerRadius(45)
                        }
                    }
                }
            }
            .padding(4)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Constants.BackgroundDefault)
            .cornerRadius(51)
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 8)
            .overlay(
                RoundedRectangle(cornerRadius: 51)
                    .inset(by: -0.5)
                    .stroke(Constants.BackgroundBorder, lineWidth: 1)
            )
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity,alignment: .center)
    }
}
