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
    @NSManaged public var creationDate: Date
    @NSManaged public var name: String
    @NSManaged public var bloodType: String
    @NSManaged public var birthday: Date
    @NSManaged public var prefecture: PrefectureEntity

}

extension PersonEntity : Identifiable {

}
