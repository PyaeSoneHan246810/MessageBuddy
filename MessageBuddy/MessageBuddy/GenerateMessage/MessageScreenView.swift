//
//  MessageScreenView.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import SwiftUI

struct MessageScreenModel: Hashable {
    let messageIdea: String
    let keyPoints: [KeyPoint]
    let purpose: Purpose
    let tone: Tone
    let language: Language
    let messageLength: MessageLength
}

struct MessageScreenView: View {
    @Binding var messageGenerator: MessageGenerator
    let screenModel: MessageScreenModel
    var purposeLabel: String {
        screenModel.purpose.labelText
    }
    var toneLabel: String {
        "\(screenModel.tone.emoji) \(screenModel.tone.labelText)"
    }
    var languageLabel: String {
        "\(screenModel.language.emoji) \(screenModel.language.labelText)"
    }
    
    var messageLengthLabel: String {
        "\(screenModel.messageLength.labelText) (\(screenModel.messageLength.description))"
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
                Text(messageGenerator.generatedMessage)
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
                Text(screenModel.messageIdea)
                    .font(.callout)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if !screenModel.keyPoints.isEmpty {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text("Key Points")
                        .font(.headline)
                    ForEach(screenModel.keyPoints) { keyPoint in
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
}

#Preview {
    NavigationStack {
        MessageScreenView(
            messageGenerator: .constant(.init()),
            screenModel: .init(messageIdea: "", keyPoints: [], purpose: .informative, tone: .formal, language: .english, messageLength: .short)
        )
    }
}
