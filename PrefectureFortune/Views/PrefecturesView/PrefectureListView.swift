//
//  PrefectureListView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct PrefectureListView: View {
    var prefectures: [Prefecture]
    @State private var sortOrder = [KeyPathComparator(\Prefecture.name)]
    
    var body: some View {
        List {
            ForEach(prefectures) { prefecture in
                NavigationLink(value: prefecture) {
                    prefectureListItem(prefecture)
                }
            }
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

struct PrefectureListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PrefectureListView(prefectures: samplePrefectures)
                .previewLayout(.fixed(width: 1000, height: 500))
        }
    }
}
