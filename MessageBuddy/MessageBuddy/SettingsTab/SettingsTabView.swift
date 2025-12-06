//
//  SettingsTabView.swift
//  MessageBuddy
//
//  Created by Dylan on 1/12/25.
//

import SwiftUI

struct SettingsTabView: View {
    @AppStorage(AppStorageKeys.colorMode) private var selectedColorMode: ColorMode = .system
    @AppStorage(AppStorageKeys.fontSize) private var selectedFontSize: FontSize = .defaultFontSize
    @AppStorage(AppStorageKeys.autoSaveHistory) private var autoSaveHistory: Bool = true
    @State private var viewModel: SettingsTabViewModel = .init()
    var body: some View {
        NavigationStack {
            Form {
                aboutSectionView
                customizationSectionView
                appSettingsSectionView
                applicationSectionView
            }
            .listSectionSpacing(16.0)
            .navigationTitle(TabItem.settings.labelText)
        }
    }
}

private extension SettingsTabView {
    var aboutSectionView: some View {
        Section {
            HStack(spacing: 8.0) {
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(viewModel.appName)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(viewModel.appDescription)
                        .font(.callout)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Image(.appIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 92.0, height: 92.0)
            }
        }
    }
    func sectionHeaderView(title: String, systemImage: String) -> some View {
        LabeledContent(title) {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 28.0, height: 28.0)
                .foregroundStyle(Theme.mainGradient)
        }
        .font(.headline)
    }
    var customizationSectionView: some View {
        Section {
            sectionHeaderView(
                title: "Customization",
                systemImage: "paintbrush.fill"
            )
            Picker("Color Mode", systemImage: "iphone", selection: $selectedColorMode) {
                ForEach(ColorMode.allCases) { colorMode in
                    Text(colorMode.labelText)
                        .tag(colorMode)
                }
            }
            Picker("Font Size", systemImage: "textformat.size", selection: $selectedFontSize) {
                ForEach(FontSize.allCases) { fontSize in
                    Text(fontSize.labelText)
                        .tag(fontSize)
                }
            }
        }
    }
    var appSettingsSectionView: some View {
        Section {
            sectionHeaderView(
                title: "App Settings",
                systemImage: "gearshape"
            )
            Toggle("Auto Save History", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90", isOn: $autoSaveHistory)
                .tint(.accent)
        }
    }
    var applicationSectionView: some View {
        Section {
            sectionHeaderView(
                title: "Application",
                systemImage: "app.grid"
            )
            LabeledContent("Name", value: viewModel.appName)
            LabeledContent("Developer", value: viewModel.appDeveloper)
            LabeledContent("Designer", value: viewModel.appDesigner)
            LabeledContent("Version", value: viewModel.appVersion)
            LabeledContent("Compatibility", value: viewModel.appCompatibility)
        }
    }
}

#Preview {
    SettingsTabView()
}
