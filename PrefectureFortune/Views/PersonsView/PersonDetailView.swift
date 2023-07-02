//
//  PersonDetailView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/02
//

import SwiftUI

struct PersonDetailView: View {
    var person: PersonEntity
    
    var body: some View {
        List {
            Section {
                PersonListItem(person.convertToPerson())
            }
            Section {
                ForEach(person.predicts) { predict in
                    NavigationLink {
                        PrefectureDetailView(
                            person: predict.person.convertToPerson(),
                            prefecture: predict.prefecture.convertToPrefecture()
                        )
                    } label: {
                        LabeledContent {
                            Text(predict.prefecture.name)
                        } label: {
                            Label(predict.predictDate.yearMonthDayString, systemImage: "hands.clap")
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PersonDetailView(person: PersonEntity.preview)
        }
    }
}
