//
//  MessageScreenView.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import SwiftUI
import Toasts

struct MessageScreenModel: Hashable {}

struct MessageScreenView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentToast) private var presentToast
    @State private var viewModel: MessageScreenViewModel = .init()
    @Binding var messageGenerator: MessageGenerator
    var purposeLabel: String {
        messageGenerator.purpose.labelText
    }
    var toneLabel: String {
        "\(messageGenerator.tone.emoji) \(messageGenerator.tone.labelText)"
    }
    var languageLabel: String {
        "\(messageGenerator.language.emoji) \(messageGenerator.language.labelText)"
    }
    var messageLengthLabel: String {
        "\(messageGenerator.messageLength.labelText) (\(messageGenerator.messageLength.description))"
    }
    var body: some View {
        Form {
            generatedMessageSectionView
            messageIdeasKeyPointsSectionView
            messagePreferencesSectionView
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
                }
                if !messageGenerator.trimmedGeneratedMessage.isEmpty {
                    Text(messageGenerator.trimmedGeneratedMessage)
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
            HStack(spacing: 8.0) {
                Button {
                    copyMessageToClipboard()
                } label: {
                    HStack(spacing: 4.0) {
                        Image(systemName: "document.on.document")
                            .imageScale(.large)
                        Text("Copy Message")
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50.0)
                    .background(Theme.mainGradient, in: .capsule)
                }
                .buttonStyle(.borderless)
                Button {
                    presentShareMessageSheet()
                } label: {
                    HStack(spacing: 4.0) {
                        Image(systemName: "square.and.arrow.up")
                            .imageScale(.large)
                        Text("Share Message")
                    }
                    .foregroundStyle(.accent)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50.0)
                    .background(Color(uiColor: .tertiarySystemFill), in: .capsule)
                }
                .buttonStyle(.borderless)
            }
        }
    }
    var messageIdeasKeyPointsSectionView: some View {
        Section {
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Message Idea")
                    .font(.headline)
                Text(messageGenerator.messageIdea)
                    .font(.callout)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if !messageGenerator.keyPoints.isEmpty {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Key Points")
                        .font(.headline)
                    ForEach(messageGenerator.keyPoints) { keyPoint in
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
    var messagePreferencesSectionView: some View {
        Section {
            LabeledContent {
                Text(purposeLabel).font(.callout)
            } label: {
                Text("Purpose").font(.headline)
            }
            LabeledContent {
                Text(toneLabel).font(.callout)
            } label: {
                Text("Tone").font(.headline)
            }
            LabeledContent {
                Text(languageLabel).font(.callout)
            } label: {
                Text("Language").font(.headline)
            }
            LabeledContent {
                Text(messageLengthLabel).font(.callout)
            } label: {
                Text("Message Length").font(.headline)
            }
        }
    }
    var shareMessageSheetView: some View {
        ActivityView(
            text: messageGenerator.generatedMessage
        )
        .presentationDetents([.medium, .large])
    }
    var editMessageSheetView: some View {
        return NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    TextField(
                        "Enter the message to edit",
                        text: $viewModel.editedMessage,
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
                        viewModel.isEditMessageSheetPresented = false
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .confirm) {
                        confirmGeneratedMessageEdit()
                    }
                }
            }
        }
        .presentationDetents([.medium, .large])
        .interactiveDismissDisabled()
        .onAppear {
            viewModel.editedMessage = messageGenerator.generatedMessage
        }
    }
}

private extension MessageScreenView {
    func confirmGeneratedMessageEdit() {
        if viewModel.trimmedEditedMessage.isEmpty {
            presentToast(
                image: "exclamationmark.circle",
                message: "Please enter the message to save.",
                imageStyle: .pink.gradient
            )
        } else {
            messageGenerator.generatedMessage = viewModel.trimmedEditedMessage
            viewModel.isEditMessageSheetPresented = false
        }
    }
    func copyMessageToClipboard() {
        if messageGenerator.trimmedGeneratedMessage.isEmpty {
            presentToast(
                image: "exclamationmark.circle",
                message: "Please enter the message to copy.",
                imageStyle: .pink.gradient
            )
        } else {
            let uiPasteboard = UIPasteboard.general
            uiPasteboard.string = messageGenerator.generatedMessage
            if uiPasteboard.string != nil {
                presentToast(
                    image: "list.clipboard",
                    message: "Copied to clipboard.",
                    imageStyle: Theme.mainGradient
                )
            }
        }
    }
    func presentShareMessageSheet() {
        if messageGenerator.trimmedGeneratedMessage.isEmpty {
            presentToast(
                image: "exclamationmark.circle",
                message: "Please enter the message to share.",
                imageStyle: .pink.gradient
            )
        } else {
            viewModel.isShareMessageSheetPresented = true
        }
    }
    func presentToast(image: String, message: String, imageStyle: any ShapeStyle) {
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
            messageGenerator: $messageGenerator,
        )
    }
}
