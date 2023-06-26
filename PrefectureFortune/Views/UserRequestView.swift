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


struct UserRequestView_Previews: PreviewProvider {
    static var previews: some View {
        UserRequestView()
    }
}
