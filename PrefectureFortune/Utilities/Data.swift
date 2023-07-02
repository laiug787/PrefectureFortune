//
//  Data.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/02
//

import Foundation

extension Data {
    func decodeToPerson() throws -> Person {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase // SnakeCase to CamelCase
        
        do {
            return try decoder.decode(Person.self, from: self)
        } catch {
            throw APIError.invalidDecode
        }
    }
    
    func decodeToPrefecture() throws -> Prefecture {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase // SnakeCase to CamelCase
        
        do {
            return try decoder.decode(Prefecture.self, from: self)
        } catch {
            throw APIError.invalidDecode
        }
    }
}
