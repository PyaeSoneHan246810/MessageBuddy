//
//  MessageGeneratorTabViewModel.swift
//  MessageBuddy
//
//  Created by Dylan on 2/12/25.
//

import Foundation
import Observation

@Observable
class MessageGeneratorTabViewModel {
    private(set) var messageIdeas: [MessageIdea] = [
        .init(
            title: "Birthday Wish",
            description: "A warm and heartfelt message for someone’s special day.",
            emoji: "🎉",
            text: "A short message to celebrate someone's special day with warmth.",
            purpose: .supportive,
            tone: .friendly
        ),
        .init(
            title: "Conversation Starter",
            description: "A simple and engaging message to start a chat.",
            emoji: "💬",
            text: "A message to begin a light and easy conversation.",
            purpose: .casual,
            tone: .relaxed
        ),
        .init(
            title: "Compliment",
            description: "A sweet and uplifting message to brighten someone’s day.",
            emoji: "😊",
            text: "A short message to offer a kind and uplifting compliment.",
            purpose: .compliment,
            tone: .positive
        ),
        .init(
            title: "Congratulation Message",
            description: "A celebratory message for achievements and milestones.",
            emoji: "🌟",
            text: "A message to congratulate someone on an important achievement.",
            purpose: .congratulatory,
            tone: .confident
        ),
        .init(
            title: "Apology Message",
            description: "A sincere and respectful message to express regret.",
            emoji: "🙏",
            text: "A message to apologize sincerely for a recent mistake.",
            purpose: .apologetic,
            tone: .empathetic
        ),
        .init(
            title: "Funny Text",
            description: "A playful and humorous message to make someone smile.",
            emoji: "😄",
            text: "A short message to share a lighthearted joke and spark a smile.",
            purpose: .casual,
            tone: .friendly
        )
    ]

    var generateMessageScreenModel: GenerateMessageScreenModel? = nil
    
    func navigateToGenerateMessageScreen(_ screenModel: GenerateMessageScreenModel) {
        generateMessageScreenModel = screenModel
    }
}
