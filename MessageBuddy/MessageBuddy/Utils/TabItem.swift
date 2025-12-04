//
//  TabItem.swift
//  MessageBuddy
//
//  Created by Dylan on 1/12/25.
//

import Foundation

enum TabItem: String, Identifiable {
    case messageGenerator
    case history
    case settings
    case searchHistory
    var id: String {
        self.rawValue
    }
    var labelText: String {
        switch self {
        case .messageGenerator:
            "Message Generator"
        case .history:
            "History"
        case .settings:
            "Settings"
        case .searchHistory:
            "Search History"
        }
    }
    var systemImage: String {
        switch self {
        case .messageGenerator:
            "apple.intelligence"
        case .history:
            "clock.arrow.trianglehead.counterclockwise.rotate.90"
        case .settings:
            "gear"
        case .searchHistory:
            "magnifyingglass"
        }
    }
}
