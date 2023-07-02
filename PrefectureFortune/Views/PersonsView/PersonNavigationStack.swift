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
                Picker("Collections", selection: $viewStyle) {
                    Text("Persons").tag(FavoriteViewStyle.users)
                    Text("Prefecture").tag(FavoriteViewStyle.prefectures)
                }
                .pickerStyle(.segmented)
                .listRowBackground(Color.clear)
                .padding()
                
                if viewStyle == .users {
                    if personVM.persons.isEmpty {
                        Spacer()
                        ContentUnavailableView(
                            text: "No Person",
                            systemImage: "person.crop.square",
                            description: "Please add a person"
                        )
                        Spacer()
                    } else {
                        personList()
                    }
                } else if viewStyle == .prefectures {
                    if personVM.prefectures.isEmpty {
                        Spacer()
                        ContentUnavailableView(
                            text: "No Prefecture",
                            systemImage: "mappin.square",
                            description: "Please add a prefecture"
                        )
                        Spacer()
                    } else {
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
            ForEach(personVM.persons, id: \.self) { person in
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
        VStack(alignment: .leading) {
            Text(person.name)
                .font(.title2)
            HStack() {
                HStack {
                    Image(systemName: "birthday.cake.fill")
                    Text(person.birthday.yearMonthDayString)
                }
                .tagStyle(color: .orange)
                
                HStack {
                    Image(systemName: "drop.fill")
                    Text(person.bloodType)
                }
                .tagStyle(color: .red)
                
                if person.predicts.count != 0 {
                    HStack {
                        Image(systemName: "map.fill")
                        Text("\(person.predicts.count)")
                    }
                    .tagStyle(color: .cyan)
                }
                
            }
        }
    }
}

struct UserNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        PersonNavigationStack()
            .environmentObject(PersonViewModel.preview)
    }
}
