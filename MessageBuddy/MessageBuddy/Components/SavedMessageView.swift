//
//  SavedMessageView.swift
//  MessageBuddy
//
//  Created by Dylan on 4/12/25.
//

import SwiftUI
import SwiftData
import WrappingHStack

struct SavedMessageView: View {
    @Environment(\.modelContext) private var modelContext
    let generatedMessage: GeneratedMessage
    private var date: String {
        if Calendar.current.isDateInToday(generatedMessage.date) {
            return "Today at \(generatedMessage.date.formatted(date: .omitted, time: .shortened))"
        } else {
            return generatedMessage.date.formatted(date: .abbreviated, time: .shortened)
        }
    }
    var body: some View {
        VStack(spacing: 12.0) {
            HStack(spacing: 0.0) {
                Text(date)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                Spacer()
                Menu {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(generatedMessage)
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .imageScale(.large)
                }
            }
            Text(generatedMessage.message)
                .lineLimit(3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            WrappingHStack(alignment: .leading, horizontalSpacing: 6.0, verticalSpacing: 6.0) {
                capsuledInfoView(generatedMessage.purpose.labelText)
                capsuledInfoView(generatedMessage.tone.fullText)
                capsuledInfoView(generatedMessage.language.fullText)
                capsuledInfoView(generatedMessage.messageLength.fullText)
            }
        }
        .padding(16.0)
        .background(Color(uiColor: .systemGray6), in: RoundedRectangle(cornerRadius: 12.0))
    }
    private func capsuledInfoView(_ info: String) -> some View {
        Text(info)
            .font(.footnote)
            .padding(.horizontal, 8.0)
            .padding(.vertical, 4.0)
            .background {
                Capsule()
                    .stroke(lineWidth: 0.5)
                    .foregroundStyle(.accent.opacity(0.5))
            }
    }
}

#Preview {
    SavedMessageView(
        generatedMessage: PreviewData.previewGeneratedMessage
    )
}
