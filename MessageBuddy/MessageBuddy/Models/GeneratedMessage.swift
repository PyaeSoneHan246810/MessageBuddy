//
//  GeneratedMessage.swift
//  MessageBuddy
//
//  Created by Dylan on 4/12/25.
//

import Foundation
import SwiftData

@Model
class GeneratedMessage {
    var message: String
    var messageIdea: String
    var keyPoints: [KeyPoint]
    var purpose: Purpose
    var tone: Tone
    var language: Language
    var messageLength: MessageLength
    var date: Date
    init(message: String, messageIdea: String, keyPoints: [KeyPoint], purpose: Purpose, tone: Tone, language: Language, messageLength: MessageLength, date: Date) {
        self.message = message
        self.messageIdea = messageIdea
        self.keyPoints = keyPoints
        self.purpose = purpose
        self.tone = tone
        self.language = language
        self.messageLength = messageLength
        self.date = date
    }
    var trimmedMessage: String {
        message.trimmed()
    }
}
