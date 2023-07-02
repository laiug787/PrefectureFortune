//
//  IntroView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/07/02
//

import SwiftUI

struct IntroView: View {
    @State private var tabSelection: Int = 0
    @State private var user: Person = Person(name: "", birthday: YearMonthDay(date: .now), bloodType: .ab, today: YearMonthDay(date: .now))
    
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
            pageButton("Predict") {
                withAnimation {
                    tabSelection = 2
                }
            }
            .disabled(user.name.isEmpty)
        }
        .padding()
    }
    
    private var prefecturePage: some View {
        VStack {
            pageTitle("Your recomended Prefecture")
            Spacer()
            pageButton("Let's Start") {
                print("Predict")
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
    }
}
