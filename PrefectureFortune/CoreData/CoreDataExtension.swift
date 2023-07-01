//
//  CoreDataExtension.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/01
//

import Foundation

extension PersonEntity {
    public var predicts: [PredictEntity] {
        get { (predict as? Set<PredictEntity> ?? []).sorted { $0.id < $1.id } }
    }
    
    public static var preview: PersonEntity {
        let manager = CoreDataManager.instance
        let person = PersonEntity(context: manager.context)
        person.id = UUID().uuidString
        person.name = "Person name"
        person.bloodType = "ab"
        person.birthday = Date.now
        person.creationDate = Date.now
        return person
    }
}

extension PredictEntity {
    public static var preview: PredictEntity {
        let manager = CoreDataManager.instance
        let person = PredictEntity(context: manager.context)
        person.id = UUID().uuidString
        person.predictDate = Date.now
        person.person = PersonEntity.preview
        person.prefecture = PrefectureEntity.preview
        return person
    }
}

extension PrefectureEntity {
    public var predicts: [PredictEntity] {
        get { (predict as? Set<PredictEntity> ?? []).sorted { $0.id < $1.id } }
    }
    
    public static var preview: PrefectureEntity {
        let manager = CoreDataManager.instance
        let prefecture = PrefectureEntity(context: manager.context)
        prefecture.id = UUID().uuidString
        prefecture.name = "Japan"
        prefecture.creationDate = Date.now
        return prefecture
    }
}
