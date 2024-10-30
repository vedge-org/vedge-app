//
//  ContentView.swift
//  Vedge
//
//  Created by 주현명 on 10/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .ticket
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Color.black.ignoresSafeArea()
                Group {
                    TabView(selection: $selectedTab) {
                        RecommendedView()
                            .tag(Tab.recommended)
                        ExploreView()
                            .tag(Tab.explore)
                        TicketListView()
                            .tag(Tab.ticket)
                        ProfileView()
                            .tag(Tab.profile)
                    }
                    .frame(maxHeight: .infinity)
                    
                    
                    BottomNavigationBar(selectedTab: $selectedTab)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
