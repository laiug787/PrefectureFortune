//
//  UserViewModel.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/28
//

import Foundation

final class UserViewModel: ObservableObject {
    @Published var prefectures: [Prefecture]
    
    init() {
        self.prefectures = []
    }
    
    func addToFavorite(prefecture: Prefecture) {
        self.prefectures.append(prefecture)
    }
}
