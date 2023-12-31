//
//  PrefectureFetcher.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import Foundation

final class PrefectureFetcher {
    private let baseURL = "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud"
    private let endPoint = "/my_fortune"
    private let httpMethod = "POST"
    private let httpRequestHeaders = ["API-Version": "v1"]
        
    func fetchPrefectureData(person: Person) async throws -> Prefecture {
        guard let url = URL(string: baseURL + endPoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = httpRequestHeaders
        try request.httpBody = person.encodeToData()
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request)
            guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            return try data.decodeToPrefecture()
        }
    }
}

enum APIError: Error {
    case invalidURL
    case invalidRequest
    case invalidResponse
    case invalidEncode
    case invalidDecode
}
