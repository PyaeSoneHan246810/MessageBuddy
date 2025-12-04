//
//  ModelPrompts.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import Foundation
import FoundationModels

class ModelPrompts {
    static let randomMessageIdeaPrompt: Prompt = Prompt {
        "Generate one message idea according to the instructions."
    }
    
    static func generateMessagePrompt(
        idea: String,
        keyPointsTexts: [String],
        purpose: Purpose,
        tone: Tone,
        language: Language,
        messageLength: MessageLength
    ) -> Prompt {
        return Prompt {
            """
            Generate a message with the length of \(messageLength.fullText) in the \(language.fullText) language, written in a \(tone.fullText) tone, fulfilling the purpose of \(purpose.labelText).

            Instructions:
            - Use the following message idea as the main context: "\(idea)".
            - Consider all provided key points: "\(keyPointsTexts.joined(separator: ", "))".
            - Match the requested purpose, tone, and language consistently throughout the message.
            - Adjust the message length accordingly.
            - Avoid extra labels, headings, or explanations; output only a ready-to-send message.
            - Only include greeting or closing phrases (like "Dear …", "Hi …", "Warm regards …", "Best …") when absolutely necessary. By default, generate messages without these elements.
            - If any important contextual detail (e.g., recipient's name) is missing, add a placeholder like "[Recipient's Name]".
            - Ensure the message is coherent, human-like, and suitable for interpersonal communication.

            Output:
            - A single, complete, ready-to-send message.
            """
        }
    }

}
