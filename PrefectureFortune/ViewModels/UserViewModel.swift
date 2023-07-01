//
//  UserViewModel.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/28
//

import Foundation

final class UserViewModel: ObservableObject {
    @Published var users: [User]
    
    init() {
        self.users = []
    }
    
    func addToFavorite(user: User) {
        self.users.append(user)
    }
}
