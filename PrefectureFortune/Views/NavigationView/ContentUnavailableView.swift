//
//  ContentUnavailableView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/02
//

import SwiftUI

struct ContentUnavailableView: View {
    private let text: LocalizedStringKey
    private let systemImage: String
    private let description: LocalizedStringKey
    
    
    init(text: LocalizedStringKey, systemImage: String, description: LocalizedStringKey) {
        self.text = text
        self.systemImage = systemImage
        self.description = description
    }
    
    var body: some View {
        VStack {
            Image(systemName: systemImage)
                .font(.system(size: 60))
                .fontWeight(.bold)
                .padding(4)
                .foregroundColor(.secondary)
            Text(text)
                .fontWeight(.bold)
                .font(.title)
            Text(description)
                .foregroundColor(.secondary)
        }
    }
}

struct ContentUnavailableView_Previews: PreviewProvider {
    static var previews: some View {
        ContentUnavailableView(
            text: "Select a Tab",
            systemImage: "rectangle.stack",
            description: "Pick something from the list."
        )
    }
}
