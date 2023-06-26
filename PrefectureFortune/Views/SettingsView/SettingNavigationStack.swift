//
//  SettingNavigationStack.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct SettingNavigationStack: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Setting 1")
                Text("Setting 2")
                Text("Setting 3")
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        SettingNavigationStack()
    }
}
