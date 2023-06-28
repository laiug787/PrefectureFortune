//
//  PrefectureFortuneApp.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import SwiftUI

@main
struct PrefectureFortuneApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(FavoritePrefectureViewModel())
        }
    }
}
