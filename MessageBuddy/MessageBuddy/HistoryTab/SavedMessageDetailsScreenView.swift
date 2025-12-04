//
//  SavedMessageDetailsScreenView.swift
//  MessageBuddy
//
//  Created by Dylan on 5/12/25.
//

import SwiftUI
import SwiftData
import Toasts

struct SavedMessageDetailsScreenView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentToast) private var presentToast
    @State private var viewModel: SavedMessageDetailsScreenViewModel = .init()
    @Bindable var generatedMessage: GeneratedMessage
    var body: some View {
        Form {
            generatedMessageSectionView
            messageIdeasKeyPointsSectionView
            messagePreferencesSectionView
        }
        .listSectionSpacing(16.0)
        .navigationTitle("Message")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button("Delete", systemImage: "trash", role: .destructive) {
                    deleteGeneratedMessage()
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
            }
        }
        .sheet(isPresented: $viewModel.isEditMessageSheetPresented) {
            editMessageSheetView
        }
        .sheet(isPresented: $viewModel.isShareMessageSheetPresented) {
            shareMessageSheetView
        }
    }
}

private extension SavedMessageDetailsScreenView {
    var generatedMessageSectionView: some View {
        Section {
            VStack(alignment: .leading, spacing: 12.0) {
                HStack {
                    Text("Generated Message ✨")
                        .font(.headline)
                    Spacer()
                }
                if !generatedMessage.trimmedMessage.isEmpty {
                    Text(generatedMessage.trimmedMessage)
                }
                Button("Edit", systemImage: "square.and.pencil") {
                    viewModel.isEditMessageSheetPresented = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.cyan)
                .foregroundStyle(.white)
                .labelIconToTitleSpacing(4.0)
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
    var messageIdeasKeyPointsSectionView: some View {
        MessageIdeasKeyPointsSectionView(
            messageIdea: generatedMessage.messageIdea,
            keyPoints: generatedMessage.keyPoints
        )
    }
    var messagePreferencesSectionView: some View {
        MessagePreferencesSectionView(
            purpose: generatedMessage.purpose,
            tone: generatedMessage.tone,
            language: generatedMessage.language,
            messageLength: generatedMessage.messageLength
        )
    }
    var shareMessageSheetView: some View {
        ActivityView(
            text: generatedMessage.trimmedMessage
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
            viewModel.editedMessage = generatedMessage.trimmedMessage
        }
    }
}

private extension SavedMessageDetailsScreenView {
    func deleteGeneratedMessage() {
        modelContext.delete(generatedMessage)
        do {
            try modelContext.save()
            dismiss()
        } catch {
            presentToastMessage(
                image: "exclamationmark.circle",
                message: "Unable to delete message. Please try again.",
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
            generatedMessage.message = viewModel.trimmedEditedMessage
            viewModel.isEditMessageSheetPresented = false
        }
    }
    func copyMessageToClipboard() {
        if generatedMessage.trimmedMessage.isEmpty {
            presentToastMessage(
                image: "exclamationmark.circle",
                message: "Please enter the message to copy.",
                imageStyle: .pink.gradient
            )
        } else {
            let uiPasteboard = UIPasteboard.general
            uiPasteboard.string = generatedMessage.trimmedMessage
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
        if generatedMessage.trimmedMessage.isEmpty {
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
    NavigationStack {
        SavedMessageDetailsScreenView(
            generatedMessage: PreviewData.previewGeneratedMessage
        )
    }
}
