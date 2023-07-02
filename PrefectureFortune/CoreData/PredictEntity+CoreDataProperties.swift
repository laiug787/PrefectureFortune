//
//  PredictEntity+CoreDataProperties.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/01
//
//

import Foundation
import CoreData


extension PredictEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PredictEntity> {
        return NSFetchRequest<PredictEntity>(entityName: "PredictEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var predictDate: Date
    @NSManaged public var person: PersonEntity
    @NSManaged public var prefecture: PrefectureEntity

}

extension PredictEntity : Identifiable {

}
