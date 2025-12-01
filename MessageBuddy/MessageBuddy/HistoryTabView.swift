//
//  HistoryTabView.swift
//  MessageBuddy
//
//  Created by Dylan on 1/12/25.
//

import SwiftUI

struct HistoryTabView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                
            }
            .navigationTitle(TabItem.history.labelText)
        }
    }
}

#Preview {
    HistoryTabView()
}
