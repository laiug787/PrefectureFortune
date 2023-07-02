//
//  IntroView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/02
//

import SwiftUI

struct IntroView: View {
    @Environment(\.dismiss) private var dismiss
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
    }
    
    private var welcomPage: some View {
        VStack {
            pageTitle("Welcome to PrefectureFortune")
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
            pageTitle("Enter Your Profile")
            Spacer()
            PredictRequestListItem(person: $settingVM.account) {
                print("profile changed")
            }
            .padding()
            Spacer()
            pageButton("Predict") {
                withAnimation {
                    tabSelection = 2
                }
            }
            .disabled(settingVM.account.name.isEmpty)
        }
        .padding()
    }
    
    private var prefecturePage: some View {
        VStack {
            pageTitle("Your recomended Prefecture")
            Spacer()
            PrefectureListItem(Prefecture.preview)
                .padding()
            Spacer()
            pageButton("Let's Start") {
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
    }
}
