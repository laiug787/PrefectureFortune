//
//  User.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import Foundation

struct User: Codable {
    var name: String
    var birthday: YearMonthDay
    var bloodType: BloodType
    var today: YearMonthDay
}

extension User {
    static var preview: User {
        let name: String = "Yamada Taro"
        let birthday: YearMonthDay = YearMonthDay(year: 2000, month: 1, day: 1)
        let bloodType: BloodType = BloodType.ab
        let today: YearMonthDay = YearMonthDay(date: Date.now)
        
        return User(name: name, birthday: birthday, bloodType: bloodType, today: today)
    }
}

struct YearMonthDay: Codable {
    var year: Int
    var month: Int
    var day: Int
    var date: Date {
        get {
            var dateComponents = DateComponents()
            dateComponents.year = year
            dateComponents.month = month
            dateComponents.day = day
            
            let calendar = Calendar.current
            guard let date = calendar.date(from: dateComponents) else {
                print("Failed to convert to Date type")
                return Date.now
            }
            return date
        }
        set {
            let calendar = Calendar(identifier: .gregorian)
            self.year = calendar.component(.year, from: newValue)
            self.month = calendar.component(.month, from: newValue)
            self.day = calendar.component(.day, from: newValue)
        }
    }
    
    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
    
    init(date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        self.year = calendar.component(.year, from: date)
        self.month = calendar.component(.month, from: date)
        self.day = calendar.component(.day, from: date)
    }
}

enum BloodType: String, CaseIterable, Identifiable, Codable {
    case ab, a, b, o
    var id: Self { self }
}
