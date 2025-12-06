//
//  EditMessageView.swift
//  MessageBuddy
//
//  Created by Dylan on 5/12/25.
//

import SwiftUI

struct EditMessageView: View {
    @Binding var editedMessage: String
    @Binding var isPresented: Bool
    let onConfirmButtonTapped: () -> Void
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    TextField(
                        "Enter the message to edit",
                        text: $editedMessage,
                        axis: .vertical
                    )
                }
            }
            .scrollIndicators(.hidden)
            .contentMargins(16.0)
            .navigationTitle("Edit Message")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .close) {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .confirm) {
                        onConfirmButtonTapped()
                    }
                }
            }
        }
    }
}

#Preview {
    EditMessageView(
        editedMessage: .constant(""),
        isPresented: .constant(true),
        onConfirmButtonTapped: {}
    )
}
