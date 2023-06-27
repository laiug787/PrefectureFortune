//
//  PrefectureDetailView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct PrefectureDetailView: View {
    var prefecture: Prefecture
    
    var body: some View {
        List {
            Section("Prefecture") {
                HStack(spacing: 20) {
                    AsyncImage(url: URL(string: prefecture.logoUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 5)
                            .frame(width: 100, height: 100)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 100, height: 100)
                    }
                    VStack(alignment: .leading) {
                        Text(prefecture.name)
                            .font(.title)
                        Text(prefecture.capital)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                LabeledContent("Citizen Day", value: prefecture.citizenDay?.date.monthDayString ?? "nil")
                LabeledContent("Has coast line", value: prefecture.hasCoastLine.description.capitalized)
                Text(prefecture.brief)
            }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PrefectureDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PrefectureDetailView(prefecture: samplePrefectures[1])
        }
    }
}
