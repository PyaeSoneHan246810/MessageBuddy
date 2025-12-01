//
//  MessageGeneratorTabView.swift
//  MessageBuddy
//
//  Created by Dylan on 1/12/25.
//

import SwiftUI

struct MessageGeneratorTabView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                
            }
            .navigationTitle(TabItem.messageGenerator.labelText)
        }
    }
}

#Preview {
    MessageGeneratorTabView()
}
