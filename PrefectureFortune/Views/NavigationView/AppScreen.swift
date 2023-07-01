//
//  AppScreen.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/29
//

import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    case predict
    case persons
    case prefectures
    case settings
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .predict:
            Label("Predict", systemImage: "hands.clap.fill")
        case .persons:
            Label("Collections", systemImage: "person.crop.rectangle.stack")
        case .prefectures:
            Label("Search", systemImage: "magnifyingglass")
        case .settings:
            Label("Settings", systemImage: "gear")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .predict:
            UserRequestView()
        case .persons:
            PersonNavigationStack()
        case .prefectures:
            PrefectureNavigationStack()
        case .settings:
            SettingNavigationStack()
        }
    }
}
