//
//  Language.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import Foundation

enum Language: String, Identifiable, CaseIterable {
    case english
    var id: String {
        self.rawValue
    }
    var labelText: String {
        switch self {
        case .english:
            "English"
        }
    }
    var emoji: String {
        switch self {
        case .english:
            "🇺🇸"
        }
    }
}
