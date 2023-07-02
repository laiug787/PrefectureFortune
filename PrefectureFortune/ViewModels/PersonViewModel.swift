//
//  PersonViewModel.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/28
//

import Foundation
import CoreData

final class PersonViewModel: ObservableObject {
    @Published var persons: [PersonEntity] = []
    @Published var prefectures: [PrefectureEntity] = []
    
    static let preview: PersonViewModel = PersonViewModel(.preview)
    
    let manager = CoreDataManager.instance
    
    init() {
        getPersons()
        getPrefectures()
    }
    
    private init(_ viewStatus: ViewStatus) {
        self.persons = [.preview]
        self.prefectures = [.preview]
    }
    
    private func getPersons() {
        let request = NSFetchRequest<PersonEntity>(entityName: "PersonEntity")
        persons.removeAll()
        
        do {
            persons = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching! \(error.localizedDescription)")
        }
    }
    
    private func getPrefectures() {
        let request = NSFetchRequest<PrefectureEntity>(entityName: "PrefectureEntity")
        prefectures.removeAll()
        
        do {
            prefectures = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching! \(error.localizedDescription)")
        }
    }
    
    func addToFavorite(_ user: Person, _ prefecture: Prefecture) {
        addPredict(user, prefecture)
        manager.save()
        getPersons()
        getPrefectures()
    }
}

// Person
extension PersonViewModel{
    private func addPerson(_ person: Person) -> PersonEntity {
        if let person = persons.first(where: { $0.convertToPerson() == person }) {
            return person
        } else {
            let newPerson = PersonEntity(context: manager.context)
            newPerson.id = UUID().uuidString
            newPerson.name = person.name
            newPerson.birthday = person.birthday.date
            newPerson.bloodType = person.bloodType.rawValue
            newPerson.creationDate = person.today.date
            return newPerson
        }
    }
    
    func deletePerson(_ personEntity: PersonEntity) {
        manager.context.delete(personEntity)
        manager.save()
        getPersons()
        getPrefectures()
    }
}

// Predict
extension PersonViewModel{
    private func addPredict(_ user: Person, _ prefecture: Prefecture) {
        let newPredict = PredictEntity(context: manager.context)
        newPredict.id = UUID().uuidString
        newPredict.predictDate = user.today.date
        newPredict.person = addPerson(user)
        newPredict.prefecture = addPrefecture(prefecture)
    }
}

// Prefecture
extension PersonViewModel{
    private func addPrefecture(_ prefecture: Prefecture) -> PrefectureEntity {
        if let exsistPrefecture = prefectures.first(where: { $0.id == prefecture.id }) {
            return exsistPrefecture
        } else {
            let newPrefecture = PrefectureEntity(context: manager.context)
            newPrefecture.id = prefecture.name
            newPrefecture.creationDate = Date.now
            newPrefecture.name = prefecture.name
            return newPrefecture
        }
    }
    
    func deletePrefecture(_ prefectureEntity: PrefectureEntity) {
        manager.context.delete(prefectureEntity)
        manager.save()
        getPersons()
        getPrefectures()
    }
}

enum ViewStatus {
    case release
    case preview
}
