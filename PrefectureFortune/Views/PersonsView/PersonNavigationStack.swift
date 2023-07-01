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
                
                List {
                    switch viewStyle {
                    case .users:
                        ForEach(userVM.persons) { user in
                            Text(user.name)
                        }
                    case .prefectures:
                        ForEach(userVM.prefectures) { prefecture in
                            Text(prefecture.name)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

struct UserNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        PersonNavigationStack()
            .environmentObject(PersonViewModel.preview)
    }
}
