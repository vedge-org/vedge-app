//
//  VedgeApp.swift
//  Vedge
//
//  Created by 주현명 on 10/1/24.
//

import SwiftUI

@main
struct VedgeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

enum Tab: String, CaseIterable {
    case recommended = "맞춤"
    case explore = "탐색"
    case ticket = "티켓"
    case profile = "프로필"

    var iconName: String {
        switch self {
        case .recommended: return "RecommendedIcon"
        case .explore: return "ExploreIcon"
        case .ticket: return "TicketIcon"
        case .profile: return "PersonIcon"
        }
    }
}


enum Screen {
    case ticketList, ticketDetail
}
