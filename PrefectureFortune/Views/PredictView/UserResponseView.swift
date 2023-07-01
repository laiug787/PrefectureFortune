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
                //                HStack(spacing: 20) {
                //                    AsyncImage(url: URL(string: prefecture.logoUrl)) { image in
                //                        image
                //                            .resizable()
                //                            .scaledToFit()
                //                            .shadow(radius: 5)
                //                            .frame(width: 100, height: 100)
                //                    } placeholder: {
                //                        ProgressView()
                //                            .frame(width: 100, height: 100)
                //                    }
                //                    VStack(alignment: .leading) {
                //                        Text(prefecture.name)
                //                            .font(.title)
                //                        Text(prefecture.capital)
                //                            .font(.subheadline)
                //                            .foregroundColor(.secondary)
                //                    }
                //                }
                //                LabeledContent("Citizen Day", value: prefecture.citizenDay?.date.monthDayString ?? "nil")
                //                LabeledContent("Has coast line", value: prefecture.hasCoastLine.description.capitalized)
                
                PrefectureListItem(prefecture)
                    .frame(height: 100)
                Text(prefecture.brief)
            }
            
            Section("Recommended for") {
                Grid(horizontalSpacing: 12) {
                    GridRow {
                        icon(systemName: "person.fill", color: .blue)
                        LabeledContent("Name", value: user.name)
                    }
                    Divider()
                    GridRow {
                        icon(systemName: "birthday.cake.fill", color: .orange)
                        LabeledContent("Birthday", value: user.birthday.date.yearMonthDayString)
                    }
                    Divider()
                    GridRow {
                        icon(systemName: "drop.fill", color: .red)
                        LabeledContent("Blood type", value: user.bloodType.rawValue.uppercased())
                    }
                }
            }
        }
        .navigationTitle("Your Results")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func icon(systemName: String, color: Color) -> some View {
        Image(systemName: systemName)
            .frame(width: 26, height: 26)
            .background(in: RoundedRectangle(cornerRadius: 5, style: .continuous))
            .backgroundStyle(color.gradient)
            .foregroundStyle(.white.shadow(.drop(radius: 1)))
    }
}

struct UserResponseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UserResponseView(user: .preview, prefecture: .preview)
        }
    }
}
