//
//  AppTabView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct AppTabView: View {
    @Binding var selection: AppScreen?
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView(selection: .constant(.predict))
            .environmentObject(PersonViewModel())
    }
}
