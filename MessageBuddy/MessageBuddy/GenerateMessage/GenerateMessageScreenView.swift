//
//  GenerateMessageScreenView.swift
//  MessageBuddy
//
//  Created by Dylan on 2/12/25.
//

import SwiftUI
import FoundationModels
import Toasts

struct GenerateMessageScreenModel: Hashable {
    let messageIdea: MessageIdea?
}

struct GenerateMessageScreenView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.presentToast) private var presentToast
    @State private var messageGenerator: MessageGenerator = .init()
    @State private var messageScreenModel: MessageScreenModel? = nil
    let screenModel: GenerateMessageScreenModel
    var body: some View {
        Group {
            if messageGenerator.isModelAvailable {
                Form {
                    messageIdeaInputView
                    keyPointsInputView
                    purposeSelectionView
                    toneSelectionView
                    languageSelectionView
                    messageLengthSelectionView
                    generateMessageButtonView
                }
                .navigationDestination(item: $messageScreenModel) { _ in
                    MessageScreenView(
                        messageGenerator: $messageGenerator
                    )
                }
                .onAppear {
                    messageGenerator.prewarmRandomMessageIdeaSession()
                }
            } else {
                if let reason = messageGenerator.modelUnavailableReason {
                    AppleIntelligenceUnavailableView(
                        reason: reason,
                        onTryAgain: {
                            messageGenerator.checkModelAvailability()
                        }
                    )
                } else {
                    ProgressView()
                }
            }
        }
        .navigationTitle("Generate Message")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            messageGenerator.checkModelAvailability()
            if let messageIdea = screenModel.messageIdea {
                setUpMessageIdea(messageIdea)
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .active {
                messageGenerator.checkModelAvailability()
            }
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
                generateRandomIdea()
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
            generateMessage()
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

private extension GenerateMessageScreenView {
    func generateRandomIdea() {
        guard messageGenerator.isModelAvailable else {
            presentAlertToast(message: "The model is not available to generate.")
            return
        }
        Task {
            await messageGenerator.generateRandomMessageIdea()
        }
    }
    func generateMessage() {
        guard !messageGenerator.trimmedMessageIdea.isEmpty else {
            presentAlertToast(message: "Please enter the message idea.")
            return
        }
        guard messageGenerator.isModelAvailable else {
            presentAlertToast(message: "The model is not available to generate.")
            return
        }
        navigateToMessageScreen()
        Task {
            await messageGenerator.generateMessage()
        }
    }
    func navigateToMessageScreen() {
        let screenModel: MessageScreenModel = .init()
        messageScreenModel = screenModel
    }
    func presentAlertToast(message: String) {
        let toastValue = ToastValue(
            icon: Image(systemName: "exclamationmark.circle").foregroundStyle(.pink.gradient),
            message: message
        )
        presentToast(toastValue)
    }
    func setUpMessageIdea(_ messageIdea: MessageIdea) {
        messageGenerator.messageIdea = messageIdea.text
        messageGenerator.tone = messageIdea.tone
        messageGenerator.purpose = messageIdea.purpose
    }
}

#Preview {
    NavigationStack {
        GenerateMessageScreenView(
            screenModel: .init(messageIdea: nil)
        )
    }
}
