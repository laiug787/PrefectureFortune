//
//  SettingViewModel.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/29
//

import SwiftUI

final class SettingViewModel: ObservableObject {
    @AppStorage("appearanceMode") var appearanceMode: DisplayMode = .system
    
    var colorScheme: ColorScheme? {
        return appearanceMode.colorScheme
    }
    
    var colorSchemeName: String {
        return appearanceMode.name
    }
    
    func settingsOpener() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

enum DisplayMode: Int, Identifiable, CaseIterable {
    case system = 0
    case light = 1
    case dark = 2
    
    var id: Self { self }
    
    var name: String {
        switch self {
        case .system:
            return String(localized: "System")
        case .light:
            return String(localized: "Light")
        case .dark:
            return String(localized: "Dark")
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return .none
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

struct AppearanceModifier: ViewModifier {
    @ObservedObject var settingVM = SettingViewModel()
    
    public func body(content: Content) -> some View { content
        .preferredColorScheme(settingVM.colorScheme)
    }
}
