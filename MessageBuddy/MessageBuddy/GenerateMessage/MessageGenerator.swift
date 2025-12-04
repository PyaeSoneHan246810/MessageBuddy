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
    
    var trimmedMessageIdea: String {
        messageIdea.trimmed()
    }
    
    var generatedMessage: String = ""
    
    var trimmedGeneratedMessage: String {
        generatedMessage.trimmed()
    }
    
    var isKeyPointsIncluded: Bool = false
    
    var keyPoints: [KeyPoint] = []
    
    var validatedKeyPoints: [KeyPoint] {
        let keyPoints = self.keyPoints.compactMap { keyPoint in
            if !keyPoint.text.trimmed().isEmpty {
                return keyPoint
            } else {
                return nil
            }
        }
        return keyPoints
    }
    
    var purpose: Purpose = .informative
    
    var tone: Tone = .formal
    
    var language: Language = .english
    
    var messageLength: MessageLength = .short
    
    func addNewKeyPoint() {
        let newKeyPoint: KeyPoint = .init()
        keyPoints.append(newKeyPoint)
    }
    
    func removeKeyPoint(for id: UUID) {
        keyPoints.removeAll {
            $0.id == id
        }
    }
    
    private(set) var modelUnavailableReason: String? = nil
    
    var isModelAvailable: Bool {
        modelUnavailableReason == nil
    }
    
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
    
    var generateMessageErrorMessage: String?
    
    func checkModelAvailability() {
        switch SystemLanguageModel.default.availability {
        case .available:
            modelUnavailableReason = nil
        case .unavailable(.deviceNotEligible):
            modelUnavailableReason = "Apple Intelligence isn't available on this device."
        case .unavailable(.appleIntelligenceNotEnabled):
            modelUnavailableReason = "Apple Intelligence is turned off. Please enable it in System Settings."
        case .unavailable(.modelNotReady):
            modelUnavailableReason = "The model for Apple Intelligence isn't ready yet. Please download or finish setting it up in System Settings."
        case .unavailable(let unknownReason):
            modelUnavailableReason = "Apple Intelligence isn't available right now. \(unknownReason)."
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
        let keyPointsTexts = validatedKeyPoints.compactMap { keyPoint in
            keyPoint.text
        }
        let prompt: Prompt = ModelPrompts.generateMessagePrompt(
            idea: trimmedMessageIdea,
            keyPointsTexts: keyPointsTexts,
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
        } catch let generationError as LanguageModelSession.GenerationError {
            withAnimation {
                generatedMessage = ""
            }
            switch generationError {
            case .guardrailViolation(_):
                generateMessageErrorMessage = "Unable to generate this message."
            case .decodingFailure(_):
                generateMessageErrorMessage = "Message generation failed."
            case .rateLimited(_):
                generateMessageErrorMessage = "Too many requests."
            default:
                generateMessageErrorMessage = "An unexpected error occurred."
            }
            if generateMessageErrorMessage != nil {
                if let failureReason = generationError.failureReason {
                    generateMessageErrorMessage! += "\n\(failureReason)."
                }
                if let recoverySuggestion = generationError.recoverySuggestion {
                    generateMessageErrorMessage! += "\n\(recoverySuggestion)."
                }
            }
        } catch {
            withAnimation {
                generatedMessage = ""
            }
            generateMessageErrorMessage = "There was an unexpected error. Please try again."
        }
    }
    
}
