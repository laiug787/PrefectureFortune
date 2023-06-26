//
//  UserRequestView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import SwiftUI

struct UserRequestView: View {
    @State private var user: User = User.preview
    @State private var prefectures: [Prefecture] = []
    
    var prefectureFetcher = PrefectureFetcher()
    
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
                    LabeledContent("Name", value: user.name)
                    LabeledContent("Birthday", value: user.birthday.date.description)
                    LabeledContent("Blood type", value: user.bloodType.rawValue)
                }
                Section {
                    Button("Predict") {
                        fetchPrefecture()
                    }
                }
            }
            .navigationTitle("Prefecture Fortune")
            .navigationDestination(for: Prefecture.self) { prefecture in
                UserResponseView(prefecture: prefecture)
            }
        }
    }
    
    func fetchPrefecture() {
        Task {
            do {
                let prefecture = try await prefectureFetcher.fetchPrefectureData(user: user)
                prefectures.append(prefecture)
            } catch APIError.invalidURL {
                print("invalid URL")
            } catch APIError.invalidRequest {
                print("invalid request")
            } catch APIError.invalidResponse {
                print("invalid response")
            } catch APIError.invalidEncode {
                print("invalid encode")
            } catch APIError.invalidDecode {
                print("invalid decode")
            }
        }
    }
}

struct User: Codable {
    var name: String
    var birthday: YearMonthDay
    var bloodType: BloodType
    var today: YearMonthDay
}

extension User {
    static var preview: User {
        let name: String = "Yamada Taro"
        let birthday: YearMonthDay = YearMonthDay(year: 2000, month: 1, day: 1)
        let bloodType: BloodType = BloodType.ab
        let today: YearMonthDay = YearMonthDay(date: Date.now)
        
        return User(name: name, birthday: birthday, bloodType: bloodType, today: today)
    }
}

struct YearMonthDay: Codable {
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

enum BloodType: String, CaseIterable, Identifiable, Codable {
    case ab, a, b, o
    var id: Self { self }
}

struct UserRequestView_Previews: PreviewProvider {
    static var previews: some View {
        UserRequestView()
    }
}
