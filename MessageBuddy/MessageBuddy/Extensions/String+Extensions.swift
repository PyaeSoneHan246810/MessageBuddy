//
//  String+Extensions.swift
//  MessageBuddy
//
//  Created by Dylan on 3/12/25.
//

import Foundation

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
