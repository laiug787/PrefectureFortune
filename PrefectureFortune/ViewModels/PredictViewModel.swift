//
//  PredictViewModel.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/28
//

import SwiftUI

final class PredictViewModel: ObservableObject {
    @Published var person: Person
    @Published var prefecture: Prefecture
    @Published var showingAlert: Bool
    
    private var prefectureFetcher: PrefectureFetcher
    
    init() {
        self.person = Person.preview
        self.prefecture = Prefecture.preview
        self.showingAlert = false
        self.prefectureFetcher = PrefectureFetcher()
    }

    func resetPrefecture() {
        prefecture = Prefecture.preview
    }
    
    @MainActor
    func predict() {
        guard !person.name.isEmpty else {
            showingAlert.toggle()
            return
        }
        Task {
            do {
                let prefecture = try await prefectureFetcher.fetchPrefectureData(user: person)
                self.prefecture = prefecture
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
