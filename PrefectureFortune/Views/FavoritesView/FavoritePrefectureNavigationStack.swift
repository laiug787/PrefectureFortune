//
//  FavoritePrefectureNavigationStack.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct FavoritePrefectureNavigationStack: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Favorite 1")
                Text("Favorite 2")
                Text("Favorite 3")
            }
            .navigationTitle("Favorites")
        }
    }
}

struct FavoritePrefectureNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePrefectureNavigationStack()
    }
}
