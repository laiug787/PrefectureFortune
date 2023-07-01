//
//  CoreDataExtension.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/01
//

import Foundation

extension PersonEntity {
    public static var preview: PersonEntity {
        let manager = CoreDataManager.instance
        let person = PersonEntity(context: manager.context)
        person.id = UUID().uuidString
        person.creationDate = Date()
        person.name = "Name"
        return person
    }
}

extension PrefectureEntity {
    public static var preview: PrefectureEntity {
        let manager = CoreDataManager.instance
        let prefecture = PrefectureEntity(context: manager.context)
        prefecture.id = "東京都"
        prefecture.creationDate = Date()
        prefecture.name = "東京都"
        return prefecture
    }
}
