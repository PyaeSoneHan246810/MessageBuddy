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
        keyPoints: [String],
        purpose: Purpose,
        tone: Tone,
        language: Language,
        messageLength: MessageLength
    ) -> Prompt {
        return Prompt {
            """
            Generate a \(messageLength.labelText) (\(messageLength.description)) message in \(language.labelText) \(language.emoji), 
            written in a \(tone.labelText) \(tone.emoji) tone, fulfilling the purpose of \(purpose.labelText).

            Instructions:
            - Use the message idea as the main context: "\(idea)".
            - Include all provided key points naturally: \(keyPoints.joined(separator: ", ")).
            - If any important contextual detail (e.g., recipient's name) is missing, add a placeholder like "[Recipient's Name]".
            - Match the requested tone, purpose, and language consistently throughout the message.
            - Adjust length according to \(messageLength.labelText): concise if short, moderately detailed if medium, fully expressive if detailed.
            - Avoid extra labels, headings, or explanations; output only a ready-to-send message.
            - Ensure the message is coherent, human-like, and suitable for interpersonal communication.

            Output:
            - A single, complete, ready-to-send message that integrates the idea and key points naturally, with placeholders added if necessary.
            """
        }
    }

}
