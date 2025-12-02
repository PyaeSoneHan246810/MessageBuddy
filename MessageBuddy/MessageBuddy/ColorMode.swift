//
//  ColorMode.swift
//  MessageBuddy
//
//  Created by Dylan on 2/12/25.
//

import SwiftUI

enum ColorMode: String, Identifiable, CaseIterable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
    var id: String {
        rawValue
    }
    var labelText: String {
        switch self {
        case .system:
            "System"
        case .light:
            "Light"
        case .dark:
            "Dark"
        }
    }
    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            nil
        case .light:
            ColorScheme.light
        case .dark:
            ColorScheme.dark
        }
    }
}
