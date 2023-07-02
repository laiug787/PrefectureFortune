//
//  Date.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/03
//

import Foundation

extension Date {
    func yearMonthDayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        return dateFormatter.string(from: self)
    }
    
    func monthDayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MM/dd"
        
        return dateFormatter.string(from: self)
    }
}
