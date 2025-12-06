//
//  FontSize.swift
//  MessageBuddy
//
//  Created by Dylan on 2/12/25.
//

import SwiftUI

enum FontSize: String, Identifiable, CaseIterable {
    case smallerFontSize
    case defaultFontSize
    case largerFontSize
    var id: String {
        self.rawValue
    }
    var labelText: String {
        switch self {
        case .smallerFontSize:
            "Smaller"
        case .defaultFontSize:
            "Default"
        case .largerFontSize:
            "Larger"
        }
    }
    var dynamicTypeSize: DynamicTypeSize {
        switch self {
        case .smallerFontSize:
            .medium
        case .defaultFontSize:
            .large
        case .largerFontSize:
            .xLarge
        }
    }
}
