//
//  ContentView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    @State private var selection: AppScreen? = .settings
    
    var prefersTabNavigation: Bool {
        if horizontalSizeClass == .compact {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        if prefersTabNavigation {
            AppTabView(selection: $selection)
        } else {
            NavigationSplitView {
                AppSidebarList(selection: $selection)
            } detail: {
                AppDetailColumn(screen: $selection)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PersonViewModel())
    }
}
