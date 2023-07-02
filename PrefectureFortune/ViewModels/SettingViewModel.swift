//
//  SettingViewModel.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/29
//

import SwiftUI

final class SettingViewModel: ObservableObject {
    @AppStorage("appearanceMode") var appearanceMode: DisplayMode = .system
    
    @AppStorage("accountName") var accountName: String = ""
    @AppStorage("accountBirthday") var accountBirthday: String = Date.now.rawValue
    @AppStorage("accountBloodType") var accountBloodType: BloodType = .ab
    
    var account: Person {
        get {
            return Person(
                name: accountName,
                birthday: YearMonthDay(date: Date(rawValue: accountBirthday)!),
                bloodType: accountBloodType,
                today: YearMonthDay(date: Date.now)
            )
        }
        set {
            accountName = newValue.name
            accountBirthday = newValue.birthday.date.rawValue
            accountBloodType = newValue.bloodType
        }
    }
    
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

extension Date: RawRepresentable {
    public var rawValue: String {
        self.timeIntervalSinceReferenceDate.description
    }
    
    public init?(rawValue: String) {
        self = Date(timeIntervalSinceReferenceDate: Double(rawValue) ?? 0.0)
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
