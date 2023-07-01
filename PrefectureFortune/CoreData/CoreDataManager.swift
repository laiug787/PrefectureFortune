//
//  CoreDataManager.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/01
//

import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    
    private let container: NSPersistentContainer
    private let containerName: String = "PrefectureFortune"
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (descrition, error) in
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving Core Data! \(error.localizedDescription)")
        }
    }
}
