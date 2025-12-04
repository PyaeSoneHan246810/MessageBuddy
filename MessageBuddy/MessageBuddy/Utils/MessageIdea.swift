//
//  MessageIdea.swift
//  MessageBuddy
//
//  Created by Dylan on 2/12/25.
//

import Foundation

struct MessageIdea: Identifiable, Hashable {
    let title: String
    let description: String
    let emoji: String
    let text: String
    let purpose: Purpose
    let tone: Tone
    var id: String {
        title
    }
}
