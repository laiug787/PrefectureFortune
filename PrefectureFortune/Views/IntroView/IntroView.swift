//
//  IntroView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/02
//

import SwiftUI

struct IntroView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var personVM: PersonViewModel
    @EnvironmentObject var settingVM: SettingViewModel
    @State private var tabSelection: Int = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            welcomPage
                .tag(0)
                .contentShape(Rectangle()).gesture(DragGesture())
            userPage
                .tag(1)
                .contentShape(Rectangle()).gesture(DragGesture())
            prefecturePage
                .tag(2)
                .contentShape(Rectangle()).gesture(DragGesture())
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .never))
        .alert("Not connected to network", isPresented: $settingVM.showingOfflineAlert) {
            Button("OK") {
                // code
            }
        } message: {
            Text("Can't be predicted.")
        }
    }
    
    private var welcomPage: some View {
        VStack {
            pageTitle("Welcome to \n PrefectureFortune")
            Spacer()
            Grid {
                GridRow {
                    Image(systemName: "hands.clap")
                    Image(systemName: "person.crop.rectangle.stack")
                }
                GridRow {
                    Image(systemName: "magnifyingglass")
                    Image(systemName: "gear")
                }
            }
            .font(.system(size: 100))
            Spacer()
            pageButton("Next") {
                withAnimation {
                    tabSelection = 1
                }
            }
        }
        .padding()
    }
    
    private var userPage: some View {
        VStack {
            pageTitle("Enter \n Your Profile")
            Spacer()
            PredictRequestListItem(person: $settingVM.account) {
                // code
            }
            .padding()
            Spacer()
            pageButton("Predict") {
                settingVM.predict()
                if settingVM.showingOfflineAlert {
                    withAnimation {
                        tabSelection = 2
                    }
                }
            }
            .disabled(settingVM.account.name.isEmpty)
        }
        .padding()
    }
    
    private var prefecturePage: some View {
        VStack {
            pageTitle("Today's horoscope")
            Spacer()
            PrefectureListItem(settingVM.prefecture)
                .padding()
            Spacer()
            pageButton("Let's Start") {
                personVM.addToFavorite(settingVM.account, settingVM.prefecture)
                dismiss()
            }
        }
        .padding()
    }
    
    private func pageTitle(_ text: LocalizedStringKey) -> some View {
        Text(text)
            .multilineTextAlignment(.center)
            .fontWeight(.bold)
            .font(.largeTitle)
            .frame(height: 140)
    }
    
    private func pageButton(_ text: LocalizedStringKey, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
        .padding()
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 12))
        .font(.largeTitle)
        .frame(height: 140)
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            IntroView()
        }
        .environmentObject(SettingViewModel())
        .environmentObject(PersonViewModel.preview)
    }
}
