//
//  AppTabView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            PrefectureNavigationStack()
                .tabItem { Label("Prefectures", systemImage: "rectangle.stack") }
            FavoritePrefectureNavigationStack()
                .tabItem { Label("Favorites", systemImage: "star.square.on.square") }
            UserRequestView()
                .tabItem { Label("Predict", systemImage: "magnifyingglass") }
            SettingNavigationStack()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
