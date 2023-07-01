//
//  SettingNavigationStack.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct SettingNavigationStack: View {
    @StateObject private var settingVM = SettingViewModel()
    @State private var presentingEditAccountSheet: Bool = false
    @State private var account: User = .preview
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    UserListItem(account)
                } header: {
                    HStack {
                        Text("My Information")
                        Spacer()
                        Button {
                            presentingEditAccountSheet = true
                        } label: {
                            Label("Edit Account", systemImage: "pencil")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
                
                Section("Display") {
                    Label {
                        Picker("Appearance", selection: $settingVM.appearanceMode) {
                            ForEach(DisplayMode.allCases) { mode in
                                Text(mode.name)
                            }
                        }
                        .pickerStyle(.menu)
                    } icon: {
                        icon(systemName: "circle.lefthalf.fill", color: .gray)
                    }
                    Button {
                        settingVM.settingsOpener()
                    } label: {
                        Label {
                            Text("Language")
                        } icon: {
                            icon(systemName: "character.book.closed", color: .gray)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $presentingEditAccountSheet) {
                EditAccountForm(account: $account)
            }
        }
    }
    
    private func icon(systemName: String, color: Color) -> some View {
        Image(systemName: systemName)
            .frame(width: 26, height: 26)
            .background(in: RoundedRectangle(cornerRadius: 5, style: .continuous))
            .backgroundStyle(color.gradient)
            .foregroundStyle(.white.shadow(.drop(radius: 1)))
    }
}

struct SettingNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        SettingNavigationStack()
    }
}
