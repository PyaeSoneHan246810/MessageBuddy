//
//  Language.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import Foundation

enum Language: String, Identifiable, CaseIterable {
    case english
    case french
    case german
    case italian
    case portuguese
    case spanish
    case japanese
    case korean

    var id: String {
        self.rawValue
    }

    var labelText: String {
        switch self {
        case .english:
            return "English"
        case .french:
            return "French"
        case .german:
            return "German"
        case .italian:
            return "Italian"
        case .portuguese:
            return "Portuguese"
        case .spanish:
            return "Spanish"
        case .japanese:
            return "Japanese"
        case .korean:
            return "Korean"
        }
    }

    var emoji: String {
        switch self {
        case .english:
            return "🇺🇸"
        case .french:
            return "🇫🇷"
        case .german:
            return "🇩🇪"
        case .italian:
            return "🇮🇹"
        case .portuguese:
            return "🇵🇹"
        case .spanish:
            return "🇪🇸"
        case .japanese:
            return "🇯🇵"
        case .korean:
            return "🇰🇷"
        }
    }
}

