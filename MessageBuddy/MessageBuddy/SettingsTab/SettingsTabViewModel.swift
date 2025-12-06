//
//  SettingsTabViewModel.swift
//  MessageBuddy
//
//  Created by Dylan on 2/12/25.
//

import Foundation
import Observation

@Observable
class SettingsTabViewModel {
    var appName: String {
        if let displayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String {
            displayName
        } else {
            "MessageBuddy"
        }
    }
    
    var appDescription: String = "An on-device AI message generator app powered by Apple’s Foundation Models, creating high-quality messages with complete privacy."
    
    var appDeveloper: String = "Pyae Sone Han"
    
    var appDesigner: String = "Pyae Sone Han"
    
    var appVersion: String {
        if let shortVersionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            shortVersionString
        } else {
            "_"
        }
    }
    
    var appCompatibility: String {
        if let minimumOSVersion = Bundle.main.infoDictionary?["MinimumOSVersion"] as? String {
            minimumOSVersion
        } else {
            "-"
        }
    }
}
