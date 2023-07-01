//
//  AppScreen.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/29
//

import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    case prefectures
    case users
    case predict
    case settings
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .prefectures:
            Label("Prefectures", systemImage: "rectangle.stack")
        case .users:
            Label("Favorites", systemImage: "star.square.on.square")
        case .predict:
            Label("Predict", systemImage: "magnifyingglass")
        case .settings:
            Label("Settings", systemImage: "gear")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .prefectures:
            PrefectureNavigationStack()
        case .users:
            UserNavigationStack()
        case .predict:
            UserRequestView()
        case .settings:
            SettingNavigationStack()
        }
    }
}
