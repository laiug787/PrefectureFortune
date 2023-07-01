//
//  PersonDetailView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/02
//

import SwiftUI

struct PersonDetailView: View {
    var person: PersonEntity
    
    var body: some View {
        List {
            Section {
                Text("Test")
            }
            Section {
                Text("Test")
            }
        }
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PersonDetailView(person: PersonEntity.preview)
        }
    }
}
