//
//  MessageScreenViewModel.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import Foundation
import Observation

@Observable
class MessageScreenViewModel {
    private(set) var message: String?
    private(set) var messageIdea: String?
    private(set) var keyPoints: [KeyPoint]?
    private(set) var tone: Tone?
    private(set) var purpose: Purpose?
    private(set) var language: Language?
    private(set) var messageLength: MessageLength?
    var toneLabel: String {
        if let tone {
            return "\(tone.emoji)\(tone.labelText)"
        } else {
            return "-"
        }
    }
    var purposeLabel: String {
        purpose?.labelText ?? "-"
    }
    var languageLabel: String {
        if let language {
            return "\(language.emoji)\(language.labelText)"
        } else {
            return "-"
        }
    }
    var messageLengthLabel: String {
        if let messageLength {
            return "\(messageLength.labelText)\(messageLength.description)"
        } else {
            return "-"
        }
    }
}
