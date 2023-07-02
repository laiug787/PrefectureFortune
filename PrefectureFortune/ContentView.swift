//
//  ContentView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import SwiftUI

struct ContentView: View {
    @AppStorage("showIntroView") var showIntroView: Bool = true
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    @State private var selection: AppScreen? = .predict
    
    var prefersTabNavigation: Bool {
        return horizontalSizeClass == .compact
    }
    
    var body: some View {
        Group {
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
        .sheet(isPresented: $showIntroView) {
            IntroView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PersonViewModel.preview)
    }
}
