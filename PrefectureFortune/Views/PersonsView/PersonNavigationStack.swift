//
//  PersonNavigationStack.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI

struct PersonNavigationStack: View {
    @EnvironmentObject var personVM: PersonViewModel
    
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
                .listRowBackground(Color.clear)
                .padding()
                
                if personVM.persons.isEmpty {
                    Spacer()
                    switch viewStyle {
                    case .users:
                        ContentUnavailableView(
                            text: "No Person",
                            systemImage: "person.crop.square",
                            description: "Please add a person"
                        )
                    case .prefectures:
                        ContentUnavailableView(
                            text: "No Prefecture",
                            systemImage: "mappin.square",
                            description: "Please add a prefecture"
                        )
                    }
                    Spacer()
                } else {
                    switch viewStyle {
                    case .users:
                        personList()
                    case .prefectures:
                        prefectureList()
                    }
                }
            }
            .navigationTitle("Collections")
        }
    }
    
    private func prefectureList() -> some View {
        List {
            ForEach(personVM.prefectures) { prefecture in
                NavigationLink {
                    PrefectureDetailView(prefecture: prefecture.convertToPrefecture())
                } label: {
                    PrefectureListItem(prefecture.convertToPrefecture())
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        personVM.deletePrefecture(prefecture)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
    }
    
    private func personList() -> some View {
        List {
            ForEach(personVM.persons) { person in
                NavigationLink {
                    PersonDetailView(person: person)
                } label: {
                    personListItem(person)
                        .padding(.horizontal)
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        personVM.deletePerson(person)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
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
                    Text(person.birthday.monthDayString())
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
