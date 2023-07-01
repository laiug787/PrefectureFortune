//
//  UserListItem.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/01
//

import SwiftUI

struct UserListItem: View {
    var user: User
    
    init(_ user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack {
            LabeledContent {
                Text(user.name)
            } label: {
                Label {
                    Text("Name")
                } icon: {
                    icon(systemName: "person.fill", color: .blue)
                }
            }
            
            Divider()
            
            LabeledContent {
                Text(user.birthday.date.yearMonthDayString)
            } label: {
                Label {
                    Text("Birthday")
                } icon: {
                    icon(systemName: "birthday.cake.fill", color: .orange)
                }
            }
            
            Divider()
            
            LabeledContent {
                Text(user.bloodType.rawValue.uppercased())
            } label: {
                Label {
                    Text("Blood Type")
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
        UserListItem(User.preview)
            .padding()
    }
}
