//
//  FavoritePrefectureNavigationStack.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct FavoritePrefectureNavigationStack: View {
    @EnvironmentObject var favoritePrefectureVM: FavoritePrefectureViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(favoritePrefectureVM.prefectures) { prefecture in
                    NavigationLink(value: prefecture) {
                        PrefectureListItem(prefecture)
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
    
    private func prefectureListItem(_ prefecture: Prefecture) -> some View {
        HStack(alignment: .center, spacing: 32) {
            AsyncImage(url: URL(string: prefecture.logoUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 5)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 70, height: 70)
            
            VStack(alignment: .leading) {
                Text(prefecture.name)
                    .font(.title)
                Text(prefecture.capital)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(minWidth: 120, maxWidth: 200, alignment: .leading)
        }
    }
}

struct FavoritePrefectureNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePrefectureNavigationStack()
            .environmentObject(FavoritePrefectureViewModel())
    }
}
