//
//  HistoryTabViewModel.swift
//  MessageBuddy
//
//  Created by Dylan on 5/12/25.
//

import Foundation
import Observation

@Observable
class HistoryTabViewModel {
    var isClearHistoryConfirmationPresented: Bool = false
    
    var selectedGeneratedMessage: GeneratedMessage?
}
