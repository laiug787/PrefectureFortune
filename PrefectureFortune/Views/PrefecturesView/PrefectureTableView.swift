//
//  PrefectureTableView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/28
//

import SwiftUI

struct PrefectureTableView: View {
    var prefectures: [Prefecture]
    
    @State private var sortOrder = [KeyPathComparator(\Prefecture.name)]
    
    var body: some View {
        Table(sortOrder: $sortOrder) {
            TableColumn("Prefecture", value: \.name) { prefecture in
                HStack(spacing: 32) {
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
                }
            }
            .width(min: 250, max: 500)
            
            TableColumn("Capital", value: \.capital) { prefecture in
                Text(prefecture.capital)
            }
            
            TableColumn("Citizen Day") { prefecture in
                Text(prefecture.citizenDay?.date.monthDayString ?? "")
            }
            
            TableColumn("Has Coast Line") { prefecture in
                Text(prefecture.hasCoastLine.description)
            }
            
            TableColumn("Details") { prefecture in
                Menu {
                    NavigationLink(value: prefecture) {
                        Label("View Details", systemImage: "list.bullet.below.rectangle")
                    }
                } label: {
                    Label("Details", systemImage: "ellipsis.circle")
                        .labelStyle(.iconOnly)
                        .contentShape(Rectangle())
                }
            }
            .width(60)
        } rows: {
            Section {
                ForEach(prefectures) { prefecture in
                    TableRow(prefecture)
                }
            }
        }
    }
}

struct PrefectureTableView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PrefectureTableView(prefectures: samplePrefectures)
        }
    }
}
