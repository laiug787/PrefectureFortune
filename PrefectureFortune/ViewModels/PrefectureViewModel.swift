//
//  PrefectureViewModel.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import Foundation

final class PrefectureViewModel: ObservableObject {
    @Published var prefectures: [Prefecture]
    @Published var prefecturePath: [Prefecture]
    @Published var viewStyle: ViewStyle
    @Published var searchText: String
    
    var searchResults: [Prefecture] {
        if searchText.isEmpty {
            return prefectures
        } else {
            return prefectures.filter { $0.name.contains(searchText) }
        }
    }
    
    init() {
        self.prefectures = samplePrefectures
        self.prefecturePath = []
        self.viewStyle = ViewStyle.gridView
        self.searchText = ""
    }
}

enum ViewStyle {
    case gridView
    case ListView
}

let samplePrefectures: [Prefecture] = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase // SnakeCase to CamelCase
    
    if let jsonURL = Bundle.main.url(forResource: "prefectures-v1", withExtension: "json"),
       let jsonData = try? Data(contentsOf: jsonURL),
       let prefectures = try? decoder.decode([Prefecture].self, from: jsonData) {
        return prefectures
    } else {
        return [Prefecture]()
    }
}()
