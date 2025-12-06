//
//  KeyPoint.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import Foundation

struct KeyPoint: Identifiable, Hashable, Codable {
    var id: UUID = .init()
    var text: String = ""
}
