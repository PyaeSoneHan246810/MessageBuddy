//
//  AppleIntelligenceUnavailableView.swift
//  MessageBuddy
//
//  Created by Dylan on 4/12/25.
//

import SwiftUI

struct AppleIntelligenceUnavailableView: View {
    let reason: String
    let onTryAgain: () -> Void
    var body: some View {
        ContentUnavailableView {
            Label("Apple Intelligence Unavailable", systemImage: "apple.intelligence")
        } description: {
            Text(reason)
        } actions: {
            Button("Try again") {
                onTryAgain()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)
        }
    }
}

#Preview {
    AppleIntelligenceUnavailableView(
        reason: "This is a reason.",
        onTryAgain: {}
    )
}
