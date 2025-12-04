//
//  EmptyHistoryView.swift
//  MessageBuddy
//
//  Created by Dylan on 5/12/25.
//

import SwiftUI

struct EmptyHistoryView: View {
    var body: some View {
        ContentUnavailableView(
            "Empty History",
            systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90",
            description: Text("Start generating messages to appear here.")
        )
    }
}

#Preview {
    EmptyHistoryView()
}
