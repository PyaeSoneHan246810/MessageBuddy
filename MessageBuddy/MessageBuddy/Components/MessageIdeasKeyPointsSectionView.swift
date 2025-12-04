//
//  MessageIdeasKeyPointsSectionView.swift
//  MessageBuddy
//
//  Created by Dylan on 5/12/25.
//

import SwiftUI

struct MessageIdeasKeyPointsSectionView: View {
    let messageIdea: String
    let keyPoints: [KeyPoint]
    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Message Idea")
                    .font(.headline)
                Text(messageIdea)
                    .font(.callout)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if !keyPoints.isEmpty {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Key Points")
                        .font(.headline)
                    ForEach(keyPoints) { keyPoint in
                        HStack(alignment: .firstTextBaseline, spacing: 8.0) {
                            Image(systemName: "arrowshape.right.fill")
                                .foregroundStyle(.secondary)
                            Text(keyPoint.text)
                        }
                        .font(.callout)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    Form {
        MessageIdeasKeyPointsSectionView(
            messageIdea: "This is a preview message idea",
            keyPoints: [
                .init(text: "This is a preview key point 1."),
                .init(text: "This is a preview key point 2.")
            ]
        )
    }
}
