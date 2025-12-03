//
//  MessageScreenView.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import SwiftUI

struct MessageScreenModel: Hashable {
    
}

struct MessageScreenView: View {
    private var viewModel: MessageScreenViewModel = .init()
    var body: some View {
        Form {
            generatedMessageSectionView
            messageIdeasKeyPointsSectionView
            messagePreferencesSectionView
        }
        .listSectionSpacing(16.0)
        .navigationTitle("Message")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension MessageScreenView {
    var generatedMessageSectionView: some View {
        Section {
            VStack(alignment: .leading, spacing: 12.0) {
                Text("Generated Message ✨")
                    .font(.headline)
                if let message = viewModel.message {
                    Text(message)
                }
                Button("Edit", systemImage: "square.and.pencil") {
                    
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
                if let messageIdea = viewModel.messageIdea {
                    Text(messageIdea)
                        .font(.callout)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Key Points")
                    .font(.headline)
                if let keyPoints = viewModel.keyPoints {
                    ForEach(keyPoints) { keyPoint in
                        HStack(alignment: .firstTextBaseline, spacing: 8.0) {
                            Image(systemName: "arrowshape.right.fill")
                                .foregroundStyle(.secondary)
                            Text(keyPoint.text)
                        }
                        .font(.callout)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    var messagePreferencesSectionView: some View {
        Section {
            LabeledContent {
                Text(viewModel.toneLabel).font(.callout)
            } label: {
                Text("Tone").font(.headline)
            }
            LabeledContent {
                Text(viewModel.purposeLabel).font(.callout)
            } label: {
                Text("Purpose").font(.headline)
            }
            LabeledContent {
                Text(viewModel.languageLabel).font(.callout)
            } label: {
                Text("Tone").font(.headline)
            }
            LabeledContent {
                Text(viewModel.messageLengthLabel).font(.callout)
            } label: {
                Text("Message Length").font(.headline)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MessageScreenView()
    }
}
