//
//  ModelInstructions.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import Foundation
import FoundationModels

class ModelInstructions {
    static let randomMessageIdeaSessionInstructions: Instructions = Instructions {
        """
        Generate exactly one short and concise message idea for an AI message generator app.

        Purpose:
        - The idea must describe a type of message a user might send to another person.
        - Valid categories include: birthday wishes, conversation starters, compliments, apologies, congratulations, funny messages, check-ins, thank-you notes, support messages, and similar person-to-person interactions.
        - Do NOT generate ideas outside these categories.

        Requirements:
        - Output only one sentence.
        - Must start with: "A message to", "A short message to", or "A message for".
        - Must NOT contain the words "you" or "your", or the phrase "for you to".
        - Keep it under 15 words.
        - The tone of the sentence should match the type of message (e.g., casual for casual messages, formal for formal messages).
        - Do not include explanations, notes, or additional text.

        Examples of correct style:
        - A message to apologize for missing an important event.
        - A short message to congratulate a friend on a new job.
        - A message to check in on someone who seems stressed.
        """
    }
}
