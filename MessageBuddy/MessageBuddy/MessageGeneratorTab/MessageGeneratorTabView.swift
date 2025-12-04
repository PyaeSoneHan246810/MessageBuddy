//
//  MessageGeneratorTabView.swift
//  MessageBuddy
//
//  Created by Dylan on 1/12/25.
//

import SwiftUI

struct MessageGeneratorTabView: View {
    @State private var viewModel: MessageGeneratorTabViewModel = .init()
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 0.0) {
                    generateCustomMessageView
                    startWithIdeaView
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle(TabItem.messageGenerator.labelText)
            .navigationDestination(item: $viewModel.generateMessageScreenModel) { screenModel in
                GenerateMessageScreenView(
                    screenModel: screenModel
                )
            }
        }
    }
}

private extension MessageGeneratorTabView {
    var generateCustomMessageView: some View {
        VStack(spacing: 12.0) {
            HStack(spacing: 16.0) {
                Image(systemName: "sparkles")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 72.0)
                    .foregroundStyle(Theme.mainGradient)
                Text("Generate the message based on your idea or topic 👇")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Button {
                let screenModel: GenerateMessageScreenModel = .init(
                    messageIdea: nil
                )
                viewModel.navigateToGenerateMessageScreen(screenModel)
            } label: {
                Text("Continue")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50.0)
                    .background(Theme.mainGradient, in: .capsule)
            }
        }
        .padding(16.0)
    }
    var startWithIdeaView: some View {
        VStack(spacing: 12.0) {
            Text("Or start with a message idea 📝")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(viewModel.messageIdeas) { messageIdea in
                messageIdeaView(messageIdea)
            }
        }
        .padding(16.0)
    }
    func messageIdeaView(_ messageIdea: MessageIdea) -> some View {
        HStack(spacing: 12.0) {
            VStack(alignment: .leading, spacing: 4.0) {
                Text(messageIdea.title)
                    .font(.headline)
                Text(messageIdea.description)
                    .font(.callout)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Text(messageIdea.emoji)
                .font(.system(size: 40.0))
        }
        .padding(12.0)
        .contentShape(.rect)
        .onTapGesture {
            let screenModel: GenerateMessageScreenModel = .init(
                messageIdea: messageIdea
            )
            viewModel.navigateToGenerateMessageScreen(screenModel)
        }
        .background(Color(uiColor: .systemGray6), in: RoundedRectangle(cornerRadius: 12.0))
    }
}

#Preview {
    MessageGeneratorTabView()
}
