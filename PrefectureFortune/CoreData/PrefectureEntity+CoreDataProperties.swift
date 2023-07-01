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
    @NSManaged public var persons: NSSet?

}

// MARK: Generated accessors for persons
extension PrefectureEntity {

    @objc(addPersonsObject:)
    @NSManaged public func addToPersons(_ value: PersonEntity)

    @objc(removePersonsObject:)
    @NSManaged public func removeFromPersons(_ value: PersonEntity)

    @objc(addPersons:)
    @NSManaged public func addToPersons(_ values: NSSet)

    @objc(removePersons:)
    @NSManaged public func removeFromPersons(_ values: NSSet)

}

extension PrefectureEntity : Identifiable {

}
