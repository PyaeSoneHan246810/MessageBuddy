//
//  SettingsTabView.swift
//  MessageBuddy
//
//  Created by Dylan on 1/12/25.
//

import SwiftUI

struct SettingsTabView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                
            }
            .navigationTitle(TabItem.settings.labelText)
        }
    }
}

#Preview {
    SettingsTabView()
}
