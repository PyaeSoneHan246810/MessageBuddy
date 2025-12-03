//
//  MessageBuddyApp.swift
//  MessageBuddy
//
//  Created by Dylan on 1/12/25.
//

import SwiftUI
import Toasts

@main
struct MessageBuddyApp: App {
    @AppStorage(AppStorageKeys.colorMode) private var selectedColorMode: ColorMode = .system
    @AppStorage(AppStorageKeys.fontSize) private var selectedFontSize: FontSize = .defaultFontSize
    var body: some Scene {
        WindowGroup {
            StartingView()
                .preferredColorScheme(selectedColorMode.colorScheme)
                .environment(\.dynamicTypeSize, selectedFontSize.dynamicTypeSize)
                .installToast(position: .bottom)
        }
    }
}
