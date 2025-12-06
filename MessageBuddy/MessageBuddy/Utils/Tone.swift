//
//  Tone.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import Foundation

enum Tone: String, Identifiable, CaseIterable, Codable {
    case formal
    case professional
    case casual
    case friendly
    case confident
    case empathetic
    case motivational
    case persuasive
    case positive
    case worried
    case relaxed
    case direct

    var id: String {
        self.rawValue
    }

    var labelText: String {
        switch self {
        case .formal:
            return "Formal"
        case .professional:
            return "Professional"
        case .casual:
            return "Casual"
        case .friendly:
            return "Friendly"
        case .confident:
            return "Confident"
        case .empathetic:
            return "Empathetic"
        case .motivational:
            return "Motivational"
        case .persuasive:
            return "Persuasive"
        case .positive:
            return "Positive"
        case .worried:
            return "Worried"
        case .relaxed:
            return "Relaxed"
        case .direct:
            return "Direct"
        }
    }

    var emoji: String {
        switch self {
        case .formal:
            return "👔"
        case .professional:
            return "💼"
        case .casual:
            return "💬"
        case .friendly:
            return "😊"
        case .confident:
            return "💪"
        case .empathetic:
            return "🤗"
        case .motivational:
            return "🚀"
        case .persuasive:
            return "🗣️"
        case .positive:
            return "🌟"
        case .worried:
            return "😟"
        case .relaxed:
            return "🧢"
        case .direct:
            return "🎯"
        }
    }
    
    var fullText: String {
        "\(emoji) \(labelText)"
    }
}

