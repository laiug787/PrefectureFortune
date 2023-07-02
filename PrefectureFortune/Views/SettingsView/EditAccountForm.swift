//
//  EditAccountForm.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/28
//

import SwiftUI

struct EditAccountForm: View {
    @Environment(\.editMode) var editMode
    @Binding var person: Person
    
    var body: some View {
        Group {
            if editMode?.wrappedValue == .inactive {
                PersonListItem(person)
                    .padding(.bottom, 3)
            } else {
                PredictRequestListItem(person: $person) {
                    print("hello")
                }
            }
        }
    }
}

struct EditAccountForm_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            EditButton()
            EditAccountForm(person: .constant(.preview))
                .padding()
        }
    }
}
