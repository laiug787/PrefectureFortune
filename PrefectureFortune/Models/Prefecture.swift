//
//  Prefecture.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import Foundation

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
        let name: String = "Japan"
        let capital: String = "Tokyo"
        let citizenDay: MonthDay? = MonthDay(month: 10, day: 1)
        let hasCoastLine: Bool  = true
        let logoUrl: String = "https://japan-map.com/wp-content/uploads/nihonchizu-dot-color-500x500.png"
        let brief: String = "Japan is a country located in East Asia. It is an archipelago consisting of four main islands: Honshu, Hokkaido, Kyushu, and Shikoku. Japan is known for its rich culture, advanced technology, and strong economy. The capital city of Japan is Tokyo. *from: ChatGPT"
        
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

extension Date {
    var yearMonthDayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        return dateFormatter.string(from: self)
    }
    
    var monthDayString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MM/dd"
        
        return dateFormatter.string(from: self)
    }
}
