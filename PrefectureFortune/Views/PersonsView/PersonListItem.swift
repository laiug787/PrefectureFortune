//
//  UserListItem.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/01
//

import SwiftUI

struct PersonListItem: View {
    var person: Person
    
    init(_ person: Person) {
        self.person = person
    }
    
    var body: some View {
        VStack {
            LabeledContent {
                Text(person.name)
            } label: {
                Label {
                    Text("Name")
                } icon: {
                    LabelIcon(systemName: "person.fill", color: .blue)
                }
            }
            
            Divider()
            
            LabeledContent {
                Text(person.birthday.date.yearMonthDayString)
            } label: {
                Label {
                    Text("Birthday")
                } icon: {
                    LabelIcon(systemName: "birthday.cake.fill", color: .orange)
                }
            }
            
            Divider()
            
            LabeledContent {
                Text(person.bloodType.rawValue.uppercased())
            } label: {
                Label {
                    Text("Blood type")
                } icon: {
                    LabelIcon(systemName: "drop.fill", color: .red)
                }
            }
        }
    }
}

struct UserListItem_Previews: PreviewProvider {
    static var previews: some View {
        PersonListItem(Person.preview)
            .padding()
    }
}
