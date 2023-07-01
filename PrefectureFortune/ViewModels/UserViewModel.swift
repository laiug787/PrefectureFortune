//
//  UserViewModel.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/28
//

import Foundation
import CoreData

final class UserViewModel: ObservableObject {
    @Published var users: [PersonEntity] = []
    @Published var prefectures: [PrefectureEntity] = []
    
    static let preview: UserViewModel = UserViewModel(.preview)
    
    let manager = CoreDataManager.instance
    
    init() {
        getPersons()
        getPrefectures()
    }
    
    private init(_ viewStatus: ViewStatus) {
        self.users = [.preview, .preview]
        self.prefectures = [.preview, .preview]
    }
    
    private func getPersons() {
        let request = NSFetchRequest<PersonEntity>(entityName: "PersonEntity")
        users.removeAll()
        
        do {
            users = try manager.context.fetch(request)
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
    
    func addToFavorite(_ user: User, _ prefecture: Prefecture) {
        addPredict(user, prefecture)
        manager.save()
        getPersons()
        getPrefectures()
    }
}

// Person
extension UserViewModel{
    func addPerson(_ user: User) -> PersonEntity {
        let newPerson = PersonEntity(context: manager.context)
        newPerson.id = UUID().uuidString
        newPerson.name = user.name
        newPerson.birthday = user.birthday.date
        newPerson.bloodType = user.bloodType.rawValue
        newPerson.creationDate = user.today.date
        return newPerson
    }
    
    func deletePerson(_ personEntity: PersonEntity) {
        manager.context.delete(personEntity)
        manager.save()
        getPersons()
        getPrefectures()
    }
}

// Predict
extension UserViewModel{
    private func addPredict(_ user: User, _ prefecture: Prefecture) {
        let newPredict = PredictEntity(context: manager.context)
        newPredict.id = UUID().uuidString
        newPredict.predictDate = user.today.date
        newPredict.person = addPerson(user)
        newPredict.prefecture = addPrefecture(prefecture)
    }
}

// Prefecture
extension UserViewModel{
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
}

enum ViewStatus {
    case release
    case preview
}
