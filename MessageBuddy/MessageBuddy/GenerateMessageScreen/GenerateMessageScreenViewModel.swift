//
//  GenerateMessageViewModel.swift
//  MessageBuddy
//
//  Created by Dylan on 2/12/25.
//

import SwiftUI
import Observation
import FoundationModels

@Observable
class GenerateMessageScreenViewModel {
    var messageIdea: String = ""
    var isKeyPointsIncluded: Bool = false
    var keyPoints: [KeyPoint] = []
    var tone: Tone = .formal
    var purpose: Purpose = .informative
    var language: Language = .english
    var messageLength: MessageLength = .short
    
    private var randomMessageIdeaSession: LanguageModelSession = .init(
        instructions: ModelInstructions.randomMessageIdeaSessionInstructions
    )
    private let randomMessageIdeaPrompt: Prompt = ModelPrompts.randomMessageIdeaPrompt
    var isRandomMessageSessionResponding: Bool {
        randomMessageIdeaSession.isResponding
    }
    
    var messageScreenModel: MessageScreenModel? = nil
    
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
    
    func navigateToMessageScreen(_ screenModel: MessageScreenModel) {
        messageScreenModel = screenModel
    }
    
}
