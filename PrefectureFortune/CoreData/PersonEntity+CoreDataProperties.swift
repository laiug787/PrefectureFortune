//
//  PersonEntity+CoreDataProperties.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/01
//
//

import Foundation
import CoreData


extension PersonEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonEntity> {
        return NSFetchRequest<PersonEntity>(entityName: "PersonEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var bloodType: String
    @NSManaged public var birthday: Date
    @NSManaged public var creationDate: Date
    @NSManaged public var predict: NSSet?

}

// MARK: Generated accessors for predict
extension PersonEntity {

    @objc(addPredictObject:)
    @NSManaged public func addToPredict(_ value: PredictEntity)

    @objc(removePredictObject:)
    @NSManaged public func removeFromPredict(_ value: PredictEntity)

    @objc(addPredict:)
    @NSManaged public func addToPredict(_ values: NSSet)

    @objc(removePredict:)
    @NSManaged public func removeFromPredict(_ values: NSSet)

}

extension PersonEntity : Identifiable {

}
