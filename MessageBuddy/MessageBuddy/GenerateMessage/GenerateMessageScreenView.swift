//
//  GenerateMessageScreenView.swift
//  MessageBuddy
//
//  Created by Dylan on 2/12/25.
//

import SwiftUI
import FoundationModels

struct GenerateMessageScreenModel: Hashable {
    
}

struct GenerateMessageScreenView: View {
    @State private var messageGenerator: MessageGenerator = .init()
    @State private var messageScreenModel: MessageScreenModel? = nil
    var body: some View {
        Form {
            messageIdeaInputView
            keyPointsInputView
            purposeSelectionView
            toneSelectionView
            languageSelectionView
            messageLengthSelectionView
            generateMessageButtonView
        }
        .navigationTitle("Generate Message")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $messageScreenModel) { screenModel in
            MessageScreenView(
                messageGenerator: $messageGenerator,
                screenModel: screenModel
            )
        }
        .onAppear {
            messageGenerator.prewarmRandomMessageIdeaSession()
        }
    }
}

private extension GenerateMessageScreenView {
    var messageIdeaInputView: some View {
        VStack(spacing: 10.0) {
            HStack {
                Text("Message Idea")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                if messageGenerator.isRandomMessageSessionResponding {
                    Image(systemName: "sparkles")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32.0, height: 32.0)
                        .foregroundStyle(Theme.mainGradient)
                        .symbolEffect(.variableColor)
                }
            }
            .animation(.spring, value: messageGenerator.isRandomMessageSessionResponding)
            TextField("Enter the idea or topic for your message", text: $messageGenerator.messageIdea, axis: .vertical)
                .frame(maxWidth: .infinity)
                .frame(minHeight: 60.0, alignment: .top)
            Button("Random Idea", systemImage: "dice") {
                Task {
                    await messageGenerator.generateRandomMessageIdea()
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.cyan)
            .foregroundStyle(.white)
            .labelIconToTitleSpacing(4.0)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    var keyPointsInputView: some View {
        VStack(spacing: 10.0) {
            Toggle("Key Points", isOn: $messageGenerator.isKeyPointsIncluded)
                .font(.headline)
            if messageGenerator.isKeyPointsIncluded {
                ForEach($messageGenerator.keyPoints.enumerated(), id: \.element.wrappedValue.id) { index, $keyPoint in
                    keyPointItemView(index: index, keyPoint: $keyPoint)
                }
                Button("Add", systemImage: "plus") {
                    messageGenerator.addNewKeyPoint()
                }
                .buttonStyle(.bordered)
                .labelIconToTitleSpacing(4.0)
                .buttonSizing(.flexible)
            }
        }
        .onChange(of: messageGenerator.isKeyPointsIncluded) {
            if messageGenerator.isKeyPointsIncluded && messageGenerator.keyPoints.isEmpty {
                messageGenerator.addNewKeyPoint()
            }
        }
    }
    func keyPointItemView(index: Int, keyPoint: Binding<KeyPoint>) -> some View {
        let keyPointNumber: Int = index + 1
        let keyPointValue: KeyPoint = keyPoint.wrappedValue
        return HStack(spacing: 12.0) {
            TextField(
                "Enter key point \(keyPointNumber)",
                text: keyPoint.text,
                axis: .vertical
            )
            .lineLimit(2)
            Image(systemName: "minus.circle")
                .imageScale(.large)
                .foregroundStyle(.pink)
                .onTapGesture {
                    messageGenerator.removeKeyPoint(for: keyPointValue.id)
                }
        }
        .padding(12.0)
        .overlay {
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(Color(uiColor: .systemGray3))
        }
    }
    var toneSelectionView: some View {
        Picker("Tone", selection: $messageGenerator.tone) {
            ForEach(Tone.allCases) { tone in
                Text("\(tone.emoji) \(tone.labelText)")
                    .tag(tone)
            }
        }
        .font(.headline)
    }
    var purposeSelectionView: some View {
        Picker("Purpose", selection: $messageGenerator.purpose) {
            ForEach(Purpose.allCases) { purpose in
                Text(purpose.labelText)
                    .tag(purpose)
            }
        }
        .font(.headline)
    }
    var languageSelectionView: some View {
        Picker("Language", selection: $messageGenerator.language) {
            ForEach(Language.allCases) { language in
                Text("\(language.emoji) \(language.labelText)")
                    .tag(language)
            }
        }
        .font(.headline)
    }
    var messageLengthSelectionView: some View {
        VStack(alignment: .leading) {
            Text("Message Length")
                .font(.headline)
            Picker(selection: $messageGenerator.messageLength) {
                ForEach(MessageLength.allCases) { messageLength in
                    HStack {
                        VStack(alignment: .leading, spacing: 0.0) {
                            Text(messageLength.labelText)
                                .font(.body)
                            Text(messageLength.description)
                                .font(.footnote)
                        }
                        Spacer()
                    }
                    .tag(messageLength)
                }
            } label: {
            }
            .pickerStyle(.navigationLink)
        }
    }
    var generateMessageButtonView: some View {
        Button {
            navigateToMessageScreen()
            Task {
                await messageGenerator.generateMessage()
            }
        } label: {
            HStack(spacing: 4.0) {
                Image(systemName: "sparkles")
                    .imageScale(.large)
                Text("Generate Message")
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50.0)
            .background(Theme.mainGradient, in: .capsule)
        }
        .buttonStyle(.borderless)
    }
}

extension GenerateMessageScreenView {
    func navigateToMessageScreen() {
        let screenModel: MessageScreenModel = .init(
            messageIdea: messageGenerator.messageIdea,
            keyPoints: messageGenerator.keyPoints,
            purpose: messageGenerator.purpose,
            tone: messageGenerator.tone,
            language: messageGenerator.language,
            messageLength: messageGenerator.messageLength
        )
        messageScreenModel = screenModel
    }
}

#Preview {
    NavigationStack {
        GenerateMessageScreenView()
    }
}
