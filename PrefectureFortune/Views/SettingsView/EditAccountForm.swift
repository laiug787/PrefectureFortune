//
//  EditAccountForm.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/28
//

import SwiftUI

struct EditAccountForm: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var account: Person
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Display Name", text: $account.name)
                } header: {
                    Label("Name", systemImage: "person.fill")
                }
                Section {
                    DatePicker("Birthday", selection: $account.birthday.date, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                } header: {
                    Label("Birthday", systemImage: "birthday.cake.fill")
                }
                Section {
                    Picker("Blood type", selection: $account.bloodType) {
                        ForEach(BloodType.allCases) { type in
                            Text(type.rawValue.uppercased())
                                .tag(type.id)
                        }
                    }
                    .pickerStyle(.segmented)
                    .listRowBackground(Color.clear)
                } header: {
                    Label("Blood type", systemImage: "drop.fill")
                }
            }
            .navigationTitle("Account Information")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct EditAccountForm_Previews: PreviewProvider {
    static var previews: some View {
        EditAccountForm(account: .constant(.preview))
    }
}
