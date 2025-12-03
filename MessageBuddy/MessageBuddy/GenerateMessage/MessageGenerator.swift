//
//  MessageGenerator.swift
//  MessageBuddy
//
//  Created by Dylan on 2/12/25.
//

import SwiftUI
import Observation
import FoundationModels

@Observable
class MessageGenerator {
    var messageIdea: String = ""
    
    var generatedMessage: String = ""
    
    var isKeyPointsIncluded: Bool = false
    
    var keyPoints: [KeyPoint] = []
    
    var purpose: Purpose = .informative
    
    var tone: Tone = .formal
    
    var language: Language = .english
    
    var messageLength: MessageLength = .short
    
    private var randomMessageIdeaSession: LanguageModelSession = .init(
        instructions: ModelInstructions.randomMessageIdeaSessionInstructions
    )
    
    private var generateMessageSession: LanguageModelSession = .init(
        instructions: ModelInstructions.generateMessageSessionInstructions
    )
    
    private let randomMessageIdeaPrompt: Prompt = ModelPrompts.randomMessageIdeaPrompt
    
    var isRandomMessageSessionResponding: Bool {
        randomMessageIdeaSession.isResponding
    }
    
    var isGenerateMessageSessionResponding: Bool {
        generateMessageSession.isResponding
    }
    
    func addNewKeyPoint() {
        let newKeyPoint: KeyPoint = .init()
        keyPoints.append(newKeyPoint)
    }
    
    func removeKeyPoint(for id: UUID) {
        keyPoints.removeAll {
            $0.id == id
        }
    }
    
    func prewarmRandomMessageIdeaSession() {
        randomMessageIdeaSession.prewarm(
            promptPrefix: randomMessageIdeaPrompt
        )
    }
    
    func generateRandomMessageIdea() async {
        withAnimation {
            messageIdea = ""
        }
        let stream = randomMessageIdeaSession.streamResponse(to: randomMessageIdeaPrompt)
        do {
            for try await partial in stream {
                let content = partial.content
                withAnimation {
                    messageIdea = content
                }
            }
        } catch {
            withAnimation {
                messageIdea = ""
            }
        }
    }
    
    func generateMessage() async {
        withAnimation {
            generatedMessage = ""
        }
        let idea = messageIdea.trimmed()
        let keyPoints = self.keyPoints.compactMap { keyPoint in
            if !keyPoint.text.trimmed().isEmpty {
                return keyPoint.text.trimmed()
            } else {
                return nil
            }
        }
        let prompt: Prompt = ModelPrompts.generateMessagePrompt(
            idea: idea,
            keyPoints: keyPoints,
            purpose: purpose,
            tone: tone,
            language: language,
            messageLength: messageLength
        )
        let stream = generateMessageSession.streamResponse(to: prompt)
        do {
            for try await partial in stream {
                let content = partial.content
                withAnimation {
                    generatedMessage = content
                }
            }
        } catch {
            withAnimation {
                generatedMessage = ""
            }
        }
    }
    
}
