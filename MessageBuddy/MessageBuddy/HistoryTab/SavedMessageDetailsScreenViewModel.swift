//
//  SavedMessageDetailsScreenViewModel.swift
//  MessageBuddy
//
//  Created by Dylan on 5/12/25.
//

import Foundation
import Observation

@Observable
class SavedMessageDetailsScreenViewModel {
    var isEditMessageSheetPresented: Bool = false
    
    var isShareMessageSheetPresented: Bool = false
    
    var editedMessage: String = ""
    
    var trimmedEditedMessage: String {
        editedMessage.trimmed()
    }
}
