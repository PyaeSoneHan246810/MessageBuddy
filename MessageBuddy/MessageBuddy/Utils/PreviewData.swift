//
//  PreviewData.swift
//  MessageBuddy
//
//  Created by Dylan on 5/12/25.
//

import Foundation

class PreviewData {
    static let previewGeneratedMessage: GeneratedMessage = .init(
        message: "This is a preview message.",
        messageIdea: "This is a preview message idea.",
        keyPoints: [
            .init(text: "This is a preview key point 1."),
            .init(text: "This is a preview key point 2.")
        ],
        purpose: .apologetic,
        tone: .empathetic,
        language: .english,
        messageLength: .short,
        date: .now
    )
}
