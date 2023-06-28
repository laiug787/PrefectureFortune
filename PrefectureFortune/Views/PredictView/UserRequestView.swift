//
//  UserRequestView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import SwiftUI

struct UserRequestView: View {
    @EnvironmentObject var favoritePrefectureVM: FavoritePrefectureViewModel
    @StateObject private var predictVM = PredictViewModel()
    @FocusState private var focusedField: FocusedField?
    @State private var isFocusedBefore: Bool = false
    
    enum FocusedField: Hashable {
        case name
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Your Information") {
                    requestView()
                }
                Section {
                    responseView()
                        .disabled(predictVM.prefecture == .preview)
                } header: {
                    Text("Recommended Prefecture")
                } footer: {
                    Text("We will find the best prefectures for you from all over Japan.")
                }
            }
            .navigationTitle("Predict For You")
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
            .alert(isPresented: $predictVM.showingAlert) {
                Alert(
                    title: Text("Enter a name"),
                    message: Text("Name can't be blank.")
                )
            }
        }
    }
    
    private func requestView() -> some View {
        Grid(horizontalSpacing: 12) {
            GridRow {
                icon(systemName: "person.fill", color: .blue)
                HStack {
                    TextField("Name", text: $predictVM.user.name)
                        .focused($focusedField, equals: .name)
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.tertiary)
                        .foregroundColor(.primary)
                        .onTapGesture {
                            focusedField = .name
                            predictVM.user.name = ""
                        }
                }
                .gridColumnAlignment(.leading)
                .gridCellColumns(2)
            }
            Divider()
            GridRow {
                icon(systemName: "birthday.cake.fill", color: .orange)
                DatePicker("Birthday", selection: $predictVM.user.birthday.date, displayedComponents: .date)
                    .gridCellColumns(2)
            }
            GridRow {
                icon(systemName: "drop.fill", color: .red)
                Text("Blood Type")
                Picker("Blood type", selection: $predictVM.user.bloodType) {
                    ForEach(BloodType.allCases) { type in
                        Text(type.rawValue.uppercased())
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }
    
    private func icon(systemName: String, color: Color) -> some View {
        Image(systemName: systemName)
            .frame(width: 26, height: 26)
            .background(in: RoundedRectangle(cornerRadius: 5, style: .continuous))
            .backgroundStyle(color.gradient)
            .foregroundStyle(.white.shadow(.drop(radius: 1)))
    }
    
    private func responseRow() -> some View {
        HStack(spacing: 20) {
            AsyncImage(url: URL(string: predictVM.prefecture.logoUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 5)
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
            VStack(alignment: .leading) {
                Text(predictVM.prefecture.name)
                    .font(.title)
                Text(predictVM.prefecture.capital)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .redacted(reason: predictVM.prefecture == .preview ? .placeholder : [])
        }
    }
    
    private func responseView() -> some View {
        NavigationLink {
            UserResponseView(user: predictVM.user, prefecture: predictVM.prefecture)
        } label: {
            responseRow()
        }
        .swipeActions(edge: .leading) {
            addToFavoriteButton()
                .tint(.yellow)
        }
        .swipeActions(edge: .trailing) {
            resetButton()
                .tint(.red)
        }
        .contextMenu {
            addToFavoriteButton()
            resetButton()
        }
    }
    
    private func addToFavoriteButton() -> some View {
        Button {
            favoritePrefectureVM.addToFavorite(prefecture: predictVM.prefecture)
        } label: {
            Label("Add", systemImage: "star")
        }
    }
    
    private func resetButton() -> some View {
        Button {
            predictVM.resetPredict()
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
        UserRequestView()
            .environmentObject(FavoritePrefectureViewModel())
    }
}
