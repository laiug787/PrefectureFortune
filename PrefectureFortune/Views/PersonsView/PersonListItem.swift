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
                    icon(systemName: "person.fill", color: .blue)
                }
            }
            
            Divider()
            
            LabeledContent {
                Text(person.birthday.date.yearMonthDayString())
            } label: {
                Label {
                    Text("Birthday")
                } icon: {
                    icon(systemName: "birthday.cake.fill", color: .orange)
                }
            }
            
            Divider()
            
            LabeledContent {
                Text(person.bloodType.rawValue.uppercased())
            } label: {
                Label {
                    Text("Blood type")
                } icon: {
                    icon(systemName: "drop.fill", color: .red)
                }
            }
        }
    }
    
    private func icon(systemName: String, color: Color) -> some View {
        Image(systemName: systemName)
            .frame(width: 26, height: 26)
            .background(in: RoundedRectangle(cornerRadius: 5, style: .continuous))
            .backgroundStyle(color.gradient)
            .foregroundStyle(.white.shadow(.drop(radius: 1)))
    }
}

struct UserListItem_Previews: PreviewProvider {
    static var previews: some View {
        PersonListItem(Person.preview)
            .padding()
    }
}
