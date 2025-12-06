//
//  View+Extensions.swift
//  MessageBuddy
//
//  Created by Dylan on 5/12/25.
//

import SwiftUI

extension View {
    func asPrimaryLargeButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            self
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50.0)
                .background(Theme.mainGradient, in: .capsule)
        }
    }
    func asSecondaryLargeButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            self
                .foregroundStyle(.accent)
                .frame(maxWidth: .infinity)
                .frame(height: 50.0)
                .background(Color(uiColor: .tertiarySystemFill), in: .capsule)
        }
    }
    func tertiaryButtonStyle() -> some View {
        self
            .buttonStyle(.borderedProminent)
            .tint(.cyan)
            .foregroundStyle(.white)
            .labelIconToTitleSpacing(4.0)
    }
    func destructiveButtonStyle() -> some View {
        self
            .buttonStyle(.borderedProminent)
            .tint(.pink)
    }
}
