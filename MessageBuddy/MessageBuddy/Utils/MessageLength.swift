//
//  MessageLength.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import Foundation

enum MessageLength: String, Identifiable, CaseIterable, Codable {
    case short
    case medium
    case detailed
    
    var id: String {
        self.rawValue
    }
    
    var labelText: String {
        switch self {
        case .short:
            "Short"
        case .medium:
            "Medium"
        case .detailed:
            "Detailed"
        }
    }
    
    var description: String {
        switch self {
        case .short:
            "50-100 words"
        case .medium:
            "100-200 words"
        case .detailed:
            "200-300 words"
        }
    }
    
    var fullText: String {
        "\(labelText) (\(description))"
    }
}
