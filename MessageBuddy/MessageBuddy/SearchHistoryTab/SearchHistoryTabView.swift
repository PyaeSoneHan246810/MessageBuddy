//
//  SearchHistoryTabView.swift
//  MessageBuddy
//
//  Created by Dylan on 1/12/25.
//

import SwiftUI

struct SearchHistoryTabView: View {
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                
            }
            .navigationTitle(TabItem.searchHistory.labelText)
            .searchable(text: $searchText)
        }
    }
}

#Preview {
    SearchHistoryTabView()
}
