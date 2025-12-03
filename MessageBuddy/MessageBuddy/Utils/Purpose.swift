//
//  Purpose.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import Foundation

enum Purpose: String, Identifiable, CaseIterable {
    case informative
    case persuasive
    case supportive
    case apologetic
    case compliment
    case reminder
    case congratulatory
    case invitation
    case checkIn
    case thankYou
    case motivational
    case casual

    var id: String {
        self.rawValue
    }

    var labelText: String {
        switch self {
        case .informative:
            return "Informative"
        case .persuasive:
            return "Persuasive"
        case .supportive:
            return "Supportive"
        case .apologetic:
            return "Apologetic"
        case .compliment:
            return "Compliment"
        case .reminder:
            return "Reminder"
        case .congratulatory:
            return "Congratulatory"
        case .invitation:
            return "Invitation"
        case .checkIn:
            return "Check-in"
        case .thankYou:
            return "Thank You"
        case .motivational:
            return "Motivational"
        case .casual:
            return "Casual"
        }
    }
}

