//
//  EmptySearchResultView.swift
//  MessageBuddy
//
//  Created by Dylan on 5/12/25.
//

import SwiftUI

struct EmptySearchResultView: View {
    var body: some View {
        ContentUnavailableView(
            "No Results Found",
            systemImage: "magnifyingglass",
            description: Text("There are no messages matching your search term.")
        )
    }
}

#Preview {
    EmptySearchResultView()
}
