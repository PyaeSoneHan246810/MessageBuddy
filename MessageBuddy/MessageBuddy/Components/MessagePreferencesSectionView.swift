//
//  MessagePreferencesSectionView.swift
//  MessageBuddy
//
//  Created by Dylan on 5/12/25.
//

import SwiftUI

struct MessagePreferencesSectionView: View {
    let purpose: Purpose
    let tone: Tone
    let language: Language
    let messageLength: MessageLength
    var body: some View {
        Section {
            labeledContentView(label: "Purpose", content: purpose.labelText)
            labeledContentView(label: "Tone", content: tone.fullText)
            labeledContentView(label: "Language", content: language.fullText)
            labeledContentView(label: "Message Length", content: messageLength.fullText)
        }
    }
    private func labeledContentView(label: String, content: String) -> some View {
        LabeledContent {
            Text(content).font(.callout)
        } label: {
            Text(label).font(.headline)
        }
    }
}

#Preview {
    Form {
        MessagePreferencesSectionView(
            purpose: .apologetic,
            tone: .casual,
            language: .english,
            messageLength: .short
        )
    }
}
