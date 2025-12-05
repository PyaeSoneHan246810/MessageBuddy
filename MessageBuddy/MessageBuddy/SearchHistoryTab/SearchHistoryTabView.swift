//
//  SearchHistoryTabView.swift
//  MessageBuddy
//
//  Created by Dylan on 1/12/25.
//

import SwiftUI
import SwiftData

struct SearchHistoryTabView: View {
    @Query(sort: \GeneratedMessage.date, order: .reverse) private var generatedMessages: [GeneratedMessage]
    @State private var selectedGeneratedMessage: GeneratedMessage?
    @State private var searchText: String = ""
    private var filteredGeneratedMessages: [GeneratedMessage] {
        getFilteredGeneratedMessages()
    }
    private var trimmedSearchText: String {
        searchText.trimmed()
    }
    var body: some View {
        NavigationStack {
            Group {
                if generatedMessages.isEmpty {
                    EmptyHistoryView()
                } else if !generatedMessages.isEmpty && filteredGeneratedMessages.isEmpty {
                    EmptySearchResultView()
                } else {
                    messagesView
                }
            }
            .navigationTitle(TabItem.searchHistory.labelText)
            .searchable(text: $searchText)
        }
    }
}

private extension SearchHistoryTabView {
    var messagesView: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 16.0) {
                ForEach(filteredGeneratedMessages) { generatedMessage in
                    SavedMessageView(generatedMessage: generatedMessage)
                        .contentShape(.rect)
                        .onTapGesture {
                            selectedGeneratedMessage = generatedMessage
                        }
                }
            }
        }
        .scrollIndicators(.hidden)
        .contentMargins(16.0)
        .navigationDestination(item: $selectedGeneratedMessage) { generatedMessage in
            SavedMessageDetailsScreenView(generatedMessage: generatedMessage)
        }
    }
}

private extension SearchHistoryTabView {
    func getFilteredGeneratedMessages() -> [GeneratedMessage] {
        let query = trimmedSearchText.lowercased()
        guard !query.isEmpty else {
            return generatedMessages
        }
        return generatedMessages.filter { item in
            let messageText = item.message.lowercased()
            let purposeText = item.purpose.labelText.lowercased()
            let toneText = item.tone.labelText.lowercased()
            let languageText = item.language.labelText.lowercased()
            return
                messageText.contains(query) ||
                purposeText.contains(query) ||
                toneText.contains(query) ||
                languageText.contains(query)
        }
    }
}

#Preview {
    SearchHistoryTabView()
}
