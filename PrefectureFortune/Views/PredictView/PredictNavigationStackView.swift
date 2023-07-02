//
//  PredictNavigationStackView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import SwiftUI

struct PredictNavigationStackView: View {
    @EnvironmentObject var favoritePrefectureVM: PersonViewModel
    @StateObject private var predictVM = PredictViewModel()
    @FocusState private var focusedField: FocusedField?
    @State private var isFocusedBefore: Bool = false
    
    enum FocusedField: Hashable {
        case name
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    PredictRequestListItem(person: $predictVM.person) {
                        predictVM.resetPrefecture()
                    }
                } header: {
                    Text("Information")
                } footer: {
                    Text("Who would you like to tell your fortune to?")
                }
                Section {
                    responseView()
                        .disabled(predictVM.prefecture == .preview)
                } header: {
                    HStack {
                        Text("Recommended Prefecture")
                        Spacer()
                        Button("Save") {
                            favoritePrefectureVM.addToFavorite(predictVM.person, predictVM.prefecture)
                        }
                        .disabled(predictVM.prefecture == .preview)
                    }
                } footer: {
                    if predictVM.prefecture == .preview {
                        Text("We will find the best prefectures for you from all over Japan.")
                    } else {
                        Text("We have found the recommended prefecture!")
                    }
                }
            }
            .navigationTitle("Today's horoscope")
            .navigationBarTitleDisplayMode(.large)
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        resetButton()
                            .tint(.gray)
                        Spacer()
                        predictButton()
                    }
                    .font(.headline)
                    .frame(height: 50)
                    .padding(8)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .controlSize(.large)
                    .shadow(radius: 4)
                }
                .padding()
            }
            .onAppear {
                guard !isFocusedBefore else { return }
                focusedField = .name
                isFocusedBefore.toggle()
            }
            .simultaneousGesture(
                DragGesture()
                    .onChanged { _ in
                        focusedField = nil
                    }
            )
            .alert("Enter a name", isPresented: $predictVM.showingAlert) {
                Button("OK") {
                    focusedField = .name
                }
            } message: {
                Text("Name can't be blank.")
            }
        }
    }
    
    private func responseView() -> some View {
        NavigationLink {
            PrefectureDetailView(person: predictVM.person, prefecture: predictVM.prefecture)
        } label: {
            PrefectureListItem(predictVM.prefecture)
                .redacted(reason: predictVM.prefecture == .preview ? .placeholder : [])
                .frame(height: 100)
        }
        .contextMenu {
            addToFavoriteButton()
        }
    }
    
    private func addToFavoriteButton() -> some View {
        Button {
            favoritePrefectureVM.addToFavorite(predictVM.person, predictVM.prefecture)
        } label: {
            Label("Add", systemImage: "star")
        }
    }
    
    private func resetButton() -> some View {
        Button {
            predictVM.resetPrefecture()
        } label: {
            Label("Reset", systemImage: "arrow.triangle.2.circlepath")
        }
    }
    
    private func predictButton() -> some View {
        Button {
            predictVM.predict()
            focusedField = nil
        } label: {
            Label("Predict", systemImage: "magnifyingglass")
        }
    }
}

struct UserRequestView_Previews: PreviewProvider {
    static var previews: some View {
        PredictNavigationStackView()
            .environmentObject(PersonViewModel())
    }
}
