//
//  MessageScreenView.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import SwiftUI
import SwiftData
import Toasts

struct MessageScreenModel: Hashable {}

struct MessageScreenView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentToast) private var presentToast
    @AppStorage(AppStorageKeys.autoSaveHistory) private var autoSaveHistory: Bool = true
    @Query private var generatedMessages: [GeneratedMessage]
    @State private var viewModel: MessageScreenViewModel = .init()
    @Binding var messageGenerator: MessageGenerator
    var body: some View {
        Form {
            generatedMessageSectionView
            messageIdeasKeyPointsSectionView
            messagePreferencesSectionView
            if !autoSaveHistory {
                saveAsHistorySectionView
            }
        }
        .listSectionSpacing(16.0)
        .navigationTitle("Message")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $viewModel.isEditMessageSheetPresented) {
            editMessageSheetView
        }
        .sheet(isPresented: $viewModel.isShareMessageSheetPresented) {
            shareMessageSheetView
        }
        .alert(
            "Error Occurred!",
            isPresented: .constant(messageGenerator.generateMessageErrorMessage != nil)
        ) {
            Button("Ok") {
                messageGenerator.generateMessageErrorMessage = nil
                dismiss()
            }
        } message: {
            if let errorMessage = messageGenerator.generateMessageErrorMessage {
                Text(errorMessage)
            }
        }
    }
}

private extension MessageScreenView {
    var generatedMessageSectionView: some View {
        Section {
            VStack(alignment: .leading, spacing: 12.0) {
                HStack {
                    Text("Generated Message ✨")
                        .font(.headline)
                    Spacer()
                    if messageGenerator.isGenerateMessageSessionResponding {
                        streamingIndicatorView
                    }
                }
                if !messageGenerator.trimmedGeneratedMessage.isEmpty {
                    Text(messageGenerator.trimmedGeneratedMessage)
                }
                Button("Edit", systemImage: "square.and.pencil") {
                    viewModel.isEditMessageSheetPresented = true
                }
                .tertiaryButtonStyle()
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            CopyShareMessageButtonsView(
                onCopyButtonTapped: {
                    copyMessageToClipboard()
                },
                onShareButtonTapped: {
                    presentShareMessageSheet()
                }
            )
        }
    }
    var streamingIndicatorView: some View {
        HStack(spacing: 4.0) {
            Image(systemName: "sparkles")
                .resizable()
                .scaledToFit()
                .frame(width: 32.0, height: 32.0)
                .symbolEffect(.variableColor)
            Text("streaming")
                .font(.callout)
        }
        .foregroundStyle(Theme.mainGradient)
    }
    var messageIdeasKeyPointsSectionView: some View {
        MessageIdeasKeyPointsSectionView(
            messageIdea: messageGenerator.trimmedMessageIdea,
            keyPoints: messageGenerator.validatedKeyPoints
        )
    }
    var messagePreferencesSectionView: some View {
        MessagePreferencesSectionView(
            purpose: messageGenerator.purpose,
            tone: messageGenerator.tone,
            language: messageGenerator.language,
            messageLength: messageGenerator.messageLength
        )
    }
    var saveAsHistorySectionView: some View {
        Section {
            Text("Save as History")
                .asSecondaryLargeButton {
                    saveGeneratedMessage()
                }
        }
    }
    var shareMessageSheetView: some View {
        ActivityView(
            text: messageGenerator.trimmedGeneratedMessage
        )
        .presentationDetents([.medium, .large])
    }
    var editMessageSheetView: some View {
        EditMessageView(
            editedMessage: $viewModel.editedMessage,
            isPresented: $viewModel.isEditMessageSheetPresented,
            onConfirmButtonTapped: {
                confirmGeneratedMessageEdit()
            }
        )
        .presentationDetents([.medium, .large])
        .interactiveDismissDisabled()
        .onAppear {
            viewModel.editedMessage = messageGenerator.trimmedGeneratedMessage
        }
    }
}

private extension MessageScreenView {
    func saveGeneratedMessage() {
        let generatedMessage: GeneratedMessage = .init(
            message: messageGenerator.trimmedGeneratedMessage,
            messageIdea: messageGenerator.trimmedMessageIdea,
            keyPoints: messageGenerator.validatedKeyPoints,
            purpose: messageGenerator.purpose,
            tone: messageGenerator.tone,
            language: messageGenerator.language,
            messageLength: messageGenerator.messageLength,
            date: .now
        )
        modelContext.insert(generatedMessage)
        do {
            try modelContext.save()
            presentToastMessage(
                image: "checkmark.circle",
                message: "Successfully saved as history.",
                imageStyle: Theme.mainGradient
            )
        } catch {
            presentToastMessage(
                image: "exclamationmark.circle",
                message: "Unable to save as history. Please try again.",
                imageStyle: .pink.gradient
            )
        }
    }
    func confirmGeneratedMessageEdit() {
        if viewModel.trimmedEditedMessage.isEmpty {
            presentToastMessage(
                image: "exclamationmark.circle",
                message: "Please enter the message to save.",
                imageStyle: .pink.gradient
            )
        } else {
            messageGenerator.generatedMessage = viewModel.trimmedEditedMessage
            if autoSaveHistory {
                if let savedGeneratedMessageId = messageGenerator.savedGeneratedMessage?.id, let savedGenratedMessage = generatedMessages.first(where: { it in
                    it.id == savedGeneratedMessageId
                }) {
                    savedGenratedMessage.message = viewModel.trimmedEditedMessage
                }
            }
            viewModel.isEditMessageSheetPresented = false
        }
    }
    func copyMessageToClipboard() {
        if messageGenerator.trimmedGeneratedMessage.isEmpty {
            presentToastMessage(
                image: "exclamationmark.circle",
                message: "Please enter the message to copy.",
                imageStyle: .pink.gradient
            )
        } else {
            let uiPasteboard = UIPasteboard.general
            uiPasteboard.string = messageGenerator.trimmedGeneratedMessage
            if uiPasteboard.string != nil {
                presentToastMessage(
                    image: "list.clipboard",
                    message: "Copied to clipboard.",
                    imageStyle: Theme.mainGradient
                )
            }
        }
    }
    func presentShareMessageSheet() {
        if messageGenerator.trimmedGeneratedMessage.isEmpty {
            presentToastMessage(
                image: "exclamationmark.circle",
                message: "Please enter the message to share.",
                imageStyle: .pink.gradient
            )
        } else {
            viewModel.isShareMessageSheetPresented = true
        }
    }
    func presentToastMessage(image: String, message: String, imageStyle: any ShapeStyle) {
        let toastValue = ToastValue(
            icon: Image(systemName: image).foregroundStyle(imageStyle),
            message: message
        )
        presentToast(toastValue)
    }
}

#Preview {
    @Previewable @State var messageGenerator: MessageGenerator = .init()
    NavigationStack {
        MessageScreenView(
            messageGenerator: $messageGenerator
        )
    }
}
