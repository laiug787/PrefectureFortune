//
//  PrefectureEntity+CoreDataProperties.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/01
//
//

import Foundation
import CoreData


extension PrefectureEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PrefectureEntity> {
        return NSFetchRequest<PrefectureEntity>(entityName: "PrefectureEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var creationDate: Date
    @NSManaged public var predict: NSSet?

}

// MARK: Generated accessors for predict
extension PrefectureEntity {

    @objc(addPredictObject:)
    @NSManaged public func addToPredict(_ value: PredictEntity)

    @objc(removePredictObject:)
    @NSManaged public func removeFromPredict(_ value: PredictEntity)

    @objc(addPredict:)
    @NSManaged public func addToPredict(_ values: NSSet)

    @objc(removePredict:)
    @NSManaged public func removeFromPredict(_ values: NSSet)

}

extension PrefectureEntity : Identifiable {

}
