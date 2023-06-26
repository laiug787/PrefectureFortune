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
        let name: String = "Toyama prefecture"
        let capital: String = "Toyama City"
        let citizenDay: MonthDay? = nil
        let hasCoastLine: Bool  = true
        let logoUrl: String = "https://japan-map.com/wp-content/uploads/toyama.png"
        let brief: String = "Toyama Prefecture is located in the Chubu region of Japan. The prefectural capital is Toyama City. \n It is located on the Sea of Japan side of the Chubu region, roughly in the center of the Hokuriku region when Niigata Prefecture is included. \n *Wikipedia, the free encyclopedia"
        
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
