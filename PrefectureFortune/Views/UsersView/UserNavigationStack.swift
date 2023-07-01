//
//  UserNavigationStack.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct UserNavigationStack: View {
    @EnvironmentObject var userVM: UserViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(userVM.users) { user in
                    UserListItem(user)
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

struct UserNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        UserNavigationStack()
            .environmentObject(UserViewModel())
    }
}
