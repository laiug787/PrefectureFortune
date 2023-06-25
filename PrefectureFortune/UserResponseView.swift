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

struct Prefecture: Hashable, Codable {
    let name: String
    let capital: String
    let citizenDay: MonthDay?
    let hasCoastLine: Bool
    let logoUrl: String
    let brief: String
}

extension Prefecture {
    static var preview: Prefecture {
        let name: String = "富山県"
        let capital: String = "富山市"
        let citizenDay: MonthDay? = nil
        let hasCoastLine: Bool  = true
        let logoUrl: String = "https://japan-map.com/wp-content/uploads/toyama.png"
        let brief: String = "富山県（とやまけん）は、日本の中部地方に位置する県。県庁所在地は富山市。\n中部地方の日本海側、新潟県を含めた場合の北陸地方のほぼ中央にある。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』"
        
        return Prefecture(name: name, capital: capital, citizenDay: citizenDay, hasCoastLine: hasCoastLine, logoUrl: logoUrl, brief: brief)
    }
}

struct MonthDay: Hashable, Codable {
    let month: Int
    let day: Int
    var date: Date {
        var dateComponents = DateComponents()
        dateComponents.month = month
        dateComponents.day = day
        
        let calendar = Calendar.current
        guard let date = calendar.date(from: dateComponents) else {
            print("Failed to convert to Date type")
            return Date.now
        }
        return date
    }
    
    init(month: Int, day: Int) {
        self.month = month
        self.day = day
    }
    
    init(date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        self.month = calendar.component(.month, from: date)
        self.day = calendar.component(.day, from: date)
    }
}

struct UserResponseView_Previews: PreviewProvider {
    static var previews: some View {
        UserResponseView(prefecture: .preview)
    }
}
