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
            HStack(spacing: 4.0) {
                Image(systemName: "document.on.document")
                    .imageScale(.large)
                Text("Copy Message")
            }
            .asPrimaryLargeButton {
                onCopyButtonTapped()
            }
            .buttonStyle(.borderless)
            HStack(spacing: 4.0) {
                Image(systemName: "square.and.arrow.up")
                    .imageScale(.large)
                Text("Share Message")
            }
            .asSecondaryLargeButton {
                onShareButtonTapped()
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
