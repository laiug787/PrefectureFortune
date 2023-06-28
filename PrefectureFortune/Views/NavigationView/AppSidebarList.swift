//
//  AppSidebarList.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/29
//

import SwiftUI

struct AppSidebarList: View {
    @Binding var selection: AppScreen?
    
    var body: some View {
        List(AppScreen.allCases, selection: $selection) { screen in
            NavigationLink(value: screen) {
                screen.label
            }
        }
        .navigationTitle("Prefecture Fortune")
    }
}

struct AppSidebarList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AppSidebarList(selection: .constant(.predict))
        }
    }
}
