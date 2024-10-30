//
//  AppViewModel.swift
//  Vedge
//
//  Created by 주현명 on 10/21/24.
//

import SwiftUI

class AppViewModel: ObservableObject {
    @Published var selectedTab: Tab = .ticket
    @Published var currentScreen: Screen = .ticketList
    
    func navigate(to screen: Screen) {
        currentScreen = screen
    }
}
