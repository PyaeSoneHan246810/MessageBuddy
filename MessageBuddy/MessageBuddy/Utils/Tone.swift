//
//  Tone.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import Foundation

enum Tone: String, Identifiable, CaseIterable {
    case formal
    var id: String {
        self.rawValue
    }
    var labelText: String {
        switch self {
        case .formal:
            "Formal"
        }
    }
    var emoji: String {
        switch self {
        case .formal:
            "👔 "
        }
    }
}
