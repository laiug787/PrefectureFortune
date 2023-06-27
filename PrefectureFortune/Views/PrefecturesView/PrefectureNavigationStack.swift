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
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70, maximum: 90), spacing: 16)], spacing: 32) {
                    ForEach(prefectureVM.searchResults) { prefecture in
                        NavigationLink(value: prefecture) {
                            VStack {
                                AsyncImage(url: URL(string: prefecture.logoUrl)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 5)
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 70, height: 70)
                                
                                Text(prefecture.name)
                                    .foregroundColor(.primary)
                                Text(prefecture.capital)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .contextMenu {
                            Button("Star") {
                                print("Star")
                            }
                        } preview: {
                            AsyncImage(url: URL(string: prefecture.logoUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .shadow(radius: 5)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 210, height: 210)
                        }
                    }
                }
                .padding([.bottom, .trailing, .leading], 16)
            }
            .navigationTitle("Prefectures")
            .navigationDestination(for: Prefecture.self) { prefecture in
                PrefectureDetailView(prefecture: prefecture)
            }
            .searchable(text: $prefectureVM.searchText)
        }
    }
}

struct PrefectureNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        PrefectureNavigationStack()
    }
}
