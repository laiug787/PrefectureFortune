//
//  UserResponseView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import SwiftUI

struct UserResponseView: View {
    var user: User
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
            
            Section("Your Profile") {
                Grid {
                    GridRow {
                        Image(systemName: "person")
                            .foregroundColor(.blue)
                        LabeledContent("Name", value: user.name)
                    }
                    Divider()
                    GridRow {
                        Image(systemName: "birthday.cake")
                            .foregroundColor(.orange)
                        LabeledContent("Birthday", value: user.birthday.date.yearMonthDayString)
                    }
                    Divider()
                    GridRow {
                        Image(systemName: "drop")
                            .foregroundColor(.red)
                        LabeledContent("Blood type", value: user.bloodType.rawValue.uppercased())
                    }
                }
            }
        }
        .navigationTitle("Your Results")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserResponseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UserResponseView(user: .preview, prefecture: .preview)
        }
    }
}
