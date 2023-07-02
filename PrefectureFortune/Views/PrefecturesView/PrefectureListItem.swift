//
//  PrefectureListItem.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/01
//

import SwiftUI

struct PrefectureListItem: View {
    var prefecture: Prefecture
    
    init(_ prefecture: Prefecture) {
        self.prefecture = prefecture
    }
    
    var body: some View {
        LabeledContent {
            VStack(alignment: .trailing, spacing: 16) {
                if let citizenDay = prefecture.citizenDay {
                    ViewThatFits(in: .horizontal) {
                        HStack {
                            Image(systemName: "calendar")
                            Text(citizenDay.date.monthDayString)
                        }
                        .frame(width: 90, alignment: .trailing)
                        Image(systemName: "calendar")
                    }
                }
                if prefecture.hasCoastLine {
                    Image(systemName: "water.waves")
                }
            }
            .font(.subheadline)
            .padding(.horizontal, 4)
        } label: {
            HStack(spacing: 20) {
                AsyncImage(url: URL(string: prefecture.logoUrl)) { image in
                    image
                        .resizable()
                        .scaledToFit()
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
                .frame(minWidth: 120, alignment: .leading)
            }
        }
    }
}

struct PrefectureListItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PrefectureListItem(samplePrefectures[1])
                .previewLayout(.fixed(width: 250, height: 100))
                .padding()
            PrefectureListItem(samplePrefectures[1])
                .previewLayout(.fixed(width: 350, height: 100))
                .padding()
        }
    }
}
