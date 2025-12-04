//
//  MessageScreenViewModel.swift
//  MessageBuddy
//
//  Created by Dylan on 4/12/25.
//

import Foundation
import Observation

@Observable
class MessageScreenViewModel {
    var isEditMessageSheetPresented: Bool = false
    
    var isShareMessageSheetPresented: Bool = false
    
    var editedMessage: String = ""
    
    var trimmedEditedMessage: String {
        editedMessage.trimmed()
    }
}
