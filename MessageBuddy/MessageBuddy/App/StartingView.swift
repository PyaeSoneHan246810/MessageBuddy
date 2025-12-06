//
//  StartingView.swift
//  MessageBuddy
//
//  Created by Dylan on 1/12/25.
//

import SwiftUI
import SwiftData

struct StartingView: View {
    var body: some View {
        MainTabView()
    }
}

#Preview {
    StartingView()
        .modelContainer(for: [GeneratedMessage.self], inMemory: true)
}
