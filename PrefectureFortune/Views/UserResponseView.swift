//
//  UserResponseView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import SwiftUI

struct UserResponseView: View {
    var prefecture: Prefecture
    
    var body: some View {
        List {
            Section("Prefecture Output") {
                AsyncImage(url: URL(string: prefecture.logoUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                LabeledContent("Name", value: prefecture.name)
                LabeledContent("Capital", value: prefecture.capital)
                LabeledContent("Citizen Day", value: prefecture.citizenDay?.date.description ?? "nil")
                LabeledContent("Has coast line", value: prefecture.hasCoastLine.description.capitalized)
            }
            Section("Brief") {
                Text(prefecture.brief)
            }
        }
    }
}

struct UserResponseView_Previews: PreviewProvider {
    static var previews: some View {
        UserResponseView(prefecture: .preview)
    }
}
