//
//  HistoryTabView.swift
//  MessageBuddy
//
//  Created by Dylan on 1/12/25.
//

import SwiftUI
import SwiftData
import Toasts

struct HistoryTabView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentToast) private var presentToast
    @Query(sort: \GeneratedMessage.date, order: .reverse) private var generatedMessages: [GeneratedMessage]
    @State private var isClearHistoryConfirmationPresented: Bool = false
    var body: some View {
        NavigationStack {
            Group {
                if generatedMessages.isEmpty {
                    emptyHistoryView
                } else {
                    savedGeneratedMessagesView
                }
            }
            .navigationTitle(TabItem.history.labelText)
        }
    }
}

private extension HistoryTabView {
    var emptyHistoryView: some View {
        ContentUnavailableView(
            "Empty History",
            systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90",
            description: Text("Start generating messages to appear here.")
        )
    }
    var savedGeneratedMessagesView: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 16.0) {
                ForEach(generatedMessages) { generatedMessage in
                    SavedGeneratedMessageView(generatedMessage: generatedMessage)
                }
            }
        }
        .scrollIndicators(.hidden)
        .contentMargins(16.0)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                clearAllButtonView
            }
        }
    }
    var clearAllButtonView: some View {
        Button("Clear All", role: .destructive) {
            isClearHistoryConfirmationPresented = true
        }
        .buttonStyle(.borderedProminent)
        .tint(.pink)
        .confirmationDialog(
            "Are you sure to clear the history?",
            isPresented: $isClearHistoryConfirmationPresented,
            titleVisibility: .visible
        ) {
            Button("Confirm", role: .destructive) {
                do {
                    try modelContext.delete(model: GeneratedMessage.self)
                } catch {
                    let toastValue = ToastValue(
                        icon: Image(systemName: "exclamationmark.circle").foregroundStyle(.pink.gradient),
                        message: "Unable to clear history. Please try again."
                    )
                    presentToast(toastValue)
                }
            }
        }
    }
}

#Preview {
    HistoryTabView()
        .modelContainer(for: [GeneratedMessage.self], inMemory: true)
}
