//
//  MessageIdea.swift
//  MessageBuddy
//
//  Created by Dylan on 2/12/25.
//

import Foundation

struct MessageIdea: Identifiable {
    let title: String
    let description: String
    let emoji: String
    var id: String {
        title
    }
}
