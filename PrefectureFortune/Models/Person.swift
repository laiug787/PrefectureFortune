//
//  Person.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import Foundation

struct Person: Identifiable, Codable, Equatable {
    var name: String
    var birthday: YearMonthDay
    var bloodType: BloodType
    var today: YearMonthDay
    
    var id: String {
        self.name
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return (lhs.name == rhs.name && lhs.birthday == rhs.birthday && lhs.bloodType == rhs.bloodType)
    }
}

extension Person {
    static var preview: Person {
        let name: String = "Yamada Taro"
        let birthday: YearMonthDay = YearMonthDay(year: 2000, month: 1, day: 1)
        let bloodType: BloodType = BloodType.ab
        let today: YearMonthDay = YearMonthDay(date: Date.now)
        
        return Person(name: name, birthday: birthday, bloodType: bloodType, today: today)
    }
    
    func encodeToData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Specify format
        encoder.keyEncodingStrategy = .convertToSnakeCase // CamelCase to SnakeCase
        
        do {
            return try encoder.encode(self)
        } catch {
            throw APIError.invalidEncode
        }
    }
}

struct YearMonthDay: Codable, Equatable {
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
    
    static func == (lhs: YearMonthDay, rhs: YearMonthDay) -> Bool {
        return (lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day)
    }
}

enum BloodType: String, CaseIterable, Identifiable, Codable {
    case ab, a, b, o
    var id: Self { self }
}
