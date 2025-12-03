//
//  Purpose.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import Foundation

enum Purpose: String, Identifiable, CaseIterable {
    case informative
    var id: String {
        self.rawValue
    }
    var labelText: String {
        switch self {
        case .informative:
            "Informative"
        }
    }
}
