//
//  PrefectureNavigationStack.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct PrefectureNavigationStack: View {    
    @StateObject private var prefectureVM = PrefectureViewModel()
    
    var body: some View {
        NavigationStack(path: $prefectureVM.prefecturePath) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70, maximum: 90), spacing: 16)], spacing: 16) {
                    ForEach(prefectureVM.prefectures) { prefecture in
                        NavigationLink(value: prefecture) {
                            AsyncImage(url: URL(string: prefecture.logoUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .shadow(radius: 5)
                                    .frame(width: 70, height: 70)
                                Text(prefecture.name)
                                    .foregroundColor(.primary)
                                Text(prefecture.capital)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 70, height: 70)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Prefectures")
            .navigationDestination(for: Prefecture.self) { prefecture in
                PrefectureDetailView(prefecture: prefecture)
            }
        }
    }
}

struct PrefectureNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        PrefectureNavigationStack()
    }
}
