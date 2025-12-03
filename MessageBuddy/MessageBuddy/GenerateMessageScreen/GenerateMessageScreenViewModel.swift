//
//  GenerateMessageViewModel.swift
//  MessageBuddy
//
//  Created by Dylan on 2/12/25.
//

import Foundation
import Observation

@Observable
class GenerateMessageScreenViewModel {
    var messageIdea: String = ""
    var isKeyPointsIncluded: Bool = false
    var keyPoints: [KeyPoint] = []
    var tone: Tone = .formal
    var purpose: Purpose = .informative
    var language: Language = .english
    var messageLength: MessageLength = .short
    var messageScreenModel: MessageScreenModel? = nil
    func navigateToMessageScreen(_ screenModel: MessageScreenModel) {
        messageScreenModel = screenModel
    }
}
