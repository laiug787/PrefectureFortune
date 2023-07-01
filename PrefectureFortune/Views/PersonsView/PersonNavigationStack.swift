//
//  PersonNavigationStack.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct PersonNavigationStack: View {
    @EnvironmentObject var userVM: PersonViewModel
    
    @State private var viewStyle: FavoriteViewStyle = .users
    
    enum FavoriteViewStyle {
        case users
        case prefectures
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Favorite", selection: $viewStyle) {
                    Text("Persons").tag(FavoriteViewStyle.users)
                    Text("Prefecture").tag(FavoriteViewStyle.prefectures)
                }
                .pickerStyle(.segmented)
                .padding()
                if !userVM.persons.isEmpty {
                    Spacer()
                    ContentUnavailableView(
                        text: "No Person",
                        systemImage: "person.crop.rectangle",
                        description: "Please add a person"
                    )
                    Spacer()
                } else {
                    List {
                        switch viewStyle {
                        case .users:
                            ForEach(userVM.persons) { person in
                                personListItem(person)
                                    .padding(.horizontal)
                            }
                        case .prefectures:
                            ForEach(userVM.prefectures) { prefecture in
                                Text(prefecture.name)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Collections")
        }
    }
    
    private func personListItem(_ person: PersonEntity) -> some View {
        LabeledContent {
            Grid(verticalSpacing: 4) {
                GridRow {
                    Image(systemName: "drop")
                    Text(person.bloodType)
                }
                GridRow {
                    Image(systemName: "birthday.cake")
                    Text(person.birthday.monthDayString)
                }
            }
        } label: {            
            Label(person.name, systemImage: "person")
                .font(.title2)
        }
    }
}

struct UserNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        PersonNavigationStack()
            .environmentObject(PersonViewModel.preview)
    }
}
