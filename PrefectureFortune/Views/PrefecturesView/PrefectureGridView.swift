//
//  PrefectureGridView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct PrefectureGridView: View {
    var prefectures: [Prefecture]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70, maximum: 90), spacing: 16)], spacing: 32) {
                ForEach(prefectures) { prefecture in
                    NavigationLink(value: prefecture) {
                        prefectureGridItem(prefecture)
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
            .padding(16)
        }
    }
    
    private func prefectureGridItem(_ prefecture: Prefecture) -> some View {
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
}

struct PrefectureGridView_Previews: PreviewProvider {
    static var previews: some View {
        PrefectureGridView(prefectures: samplePrefectures)
    }
}
