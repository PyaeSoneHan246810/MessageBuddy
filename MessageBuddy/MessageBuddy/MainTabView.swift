//
//  MainTabView.swift
//  MessageBuddy
//
//  Created by Dylan on 1/12/25.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTabItem: TabItem = .messageGenerator
    var isSearchHistoryTabVisible: Bool {
        selectedTabItem == .history || selectedTabItem == .searchHistory
    }
    var body: some View {
        TabView(selection: $selectedTabItem) {
            Tab(
                TabItem.messageGenerator.labelText,
                systemImage: TabItem.messageGenerator.systemImage,
                value: TabItem.messageGenerator
            ) {
                MessageGeneratorTabView()
            }
            Tab(
                TabItem.history.labelText,
                systemImage: TabItem.history.systemImage,
                value: TabItem.history
            ) {
                HistoryTabView()
            }
            Tab(
                TabItem.settings.labelText,
                systemImage: TabItem.settings.systemImage,
                value: TabItem.settings
            ) {
                SettingsTabView()
            }
            if isSearchHistoryTabVisible {
                Tab(
                    TabItem.searchHistory.labelText,
                    systemImage: TabItem.searchHistory.systemImage,
                    value: TabItem.searchHistory,
                    role: .search
                ){
                    SearchHistoryTabView()
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}
