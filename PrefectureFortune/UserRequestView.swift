//
//  UserRequestView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import SwiftUI

struct UserRequestView: View {
    @State private var user: User = User(
        name: "",
        birthday: YearMonthDay(date: Date.now),
        bloodType: BloodType.ab,
        today: YearMonthDay(date: Date.now)
    )
    
    @State private var prefectures: [Prefecture] = []
    
    var body: some View {
        NavigationStack(path: $prefectures) {
            List {
                Section("User Profile Input") {
                    TextField("Name", text: $user.name)
                    DatePicker("Birthday", selection: $user.birthday.date, displayedComponents: .date)
                    Picker("Blood type", selection: $user.bloodType) {
                        ForEach(BloodType.allCases) { type in
                            Text(type.rawValue.uppercased())
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("User Profile Output") {
                    LabeledContent("Name") {
                        Text(user.name)
                    }
                    LabeledContent("Birthday") {
                        Text(user.birthday.date.description)
                    }
                    LabeledContent("Blood type") {
                        Text(user.bloodType.rawValue)
                    }
                }
                Section {
                    Button("Submit") {
                        prefectures.append(Prefecture.preview)
                    }
                }
            }
            .navigationTitle("Prefecture Fortune")
            .navigationDestination(for: Prefecture.self) { prefecture in
                UserResponseView(prefecture: prefecture)
            }
        }
    }
}

struct User {
    var name: String
    var birthday: YearMonthDay
    var bloodType: BloodType
    var today: YearMonthDay
}

struct YearMonthDay {
    var year: Int
    var month: Int
    var day: Int
    var date: Date {
        get {
            var dateComponents = DateComponents()
            dateComponents.year = year
            dateComponents.month = month
            dateComponents.day = day
            
            let calendar = Calendar.current
            guard let date = calendar.date(from: dateComponents) else {
                print("Failed to convert to Date type")
                return Date.now
            }
            return date
        }
        set {
            let calendar = Calendar(identifier: .gregorian)
            self.year = calendar.component(.year, from: newValue)
            self.month = calendar.component(.month, from: newValue)
            self.day = calendar.component(.day, from: newValue)
        }
    }
    
    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
    
    init(date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        self.year = calendar.component(.year, from: date)
        self.month = calendar.component(.month, from: date)
        self.day = calendar.component(.day, from: date)
    }
}

enum BloodType: String, CaseIterable, Identifiable {
    case ab, a, b, o
    var id: Self { self }
}

struct UserRequestView_Previews: PreviewProvider {
    static var previews: some View {
        UserRequestView()
    }
}
