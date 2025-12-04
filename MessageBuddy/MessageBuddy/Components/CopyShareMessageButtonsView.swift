//
//  CopyShareMessageButtonsView.swift
//  MessageBuddy
//
//  Created by Dylan on 5/12/25.
//

import SwiftUI

struct CopyShareMessageButtonsView: View {
    let onCopyButtonTapped: () -> Void
    let onShareButtonTapped: () -> Void
    var body: some View {
        HStack(spacing: 8.0) {
            Button {
                onCopyButtonTapped()
            } label: {
                HStack(spacing: 4.0) {
                    Image(systemName: "document.on.document")
                        .imageScale(.large)
                    Text("Copy Message")
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50.0)
                .background(Theme.mainGradient, in: .capsule)
            }
            .buttonStyle(.borderless)
            Button {
                onShareButtonTapped()
            } label: {
                HStack(spacing: 4.0) {
                    Image(systemName: "square.and.arrow.up")
                        .imageScale(.large)
                    Text("Share Message")
                }
                .foregroundStyle(.accent)
                .frame(maxWidth: .infinity)
                .frame(height: 50.0)
                .background(Color(uiColor: .tertiarySystemFill), in: .capsule)
            }
            .buttonStyle(.borderless)
        }
    }
}

#Preview {
    CopyShareMessageButtonsView(
        onCopyButtonTapped: {},
        onShareButtonTapped: {}
    )
}
