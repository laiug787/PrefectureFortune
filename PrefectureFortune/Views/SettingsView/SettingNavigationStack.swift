//
//  SettingNavigationStack.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct SettingNavigationStack: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var settingVM: SettingViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    EditAccountForm(person: $settingVM.account)
                } header: {
                    HStack {
                        Text("My account")
                        Spacer()
                        EditButton()
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
            .environmentObject(SettingViewModel())
    }
}
