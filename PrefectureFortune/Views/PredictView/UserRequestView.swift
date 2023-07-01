//
//  UserRequestView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import SwiftUI

struct UserRequestView: View {
    @EnvironmentObject var favoritePrefectureVM: UserViewModel
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
                    requestView()
                } header: {
                    Text("Information")
                } footer: {
                    Text("Person you want to tell a fortune for.")
                }
                Section {
                    responseView()
                        .disabled(predictVM.prefecture == .preview)
                } header: {
                    Text("Recommended Prefecture")
                } footer: {
                    if predictVM.prefecture == .preview {
                        Text("We will find the best prefectures for you from all over Japan.")
                    } else {
                        Text("We have found the recommended prefecture!")
                    }
                }
            }
            .navigationTitle("Predict Prefecture")
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
    
    private func requestView() -> some View {
        Group {
            Label {
                HStack {
                    TextField("Name", text: $predictVM.user.name)
                        .focused($focusedField, equals: .name)
                        .onChange(of: predictVM.user.name) { _ in
                            predictVM.resetPrefecture()
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)){ obj in
                            // Process to select all text
                            if let textField = obj.object as? UITextField {
                                textField.selectedTextRange = textField.textRange(
                                    from: textField.beginningOfDocument,
                                    to: textField.endOfDocument
                                )
                            }
                        }
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.tertiary)
                        .foregroundColor(.primary)
                        .onTapGesture {
                            focusedField = .name
                            predictVM.user.name = ""
                        }
                }
            } icon: {
                icon(systemName: "person.fill", color: .blue)
            }
            Label {
                DatePicker("Birthday", selection: $predictVM.user.birthday.date, displayedComponents: .date)
                    .onChange(of: predictVM.user.birthday.date) { _ in
                        predictVM.resetPrefecture()
                    }
            } icon: {
                icon(systemName: "birthday.cake.fill", color: .orange)
            }
            Label {
                Text("Blood Type")
                Spacer()
                Picker("Blood type", selection: $predictVM.user.bloodType) {
                    ForEach(BloodType.allCases) { type in
                        Text(type.rawValue.uppercased()).tag(type.id)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: predictVM.user.bloodType) { _ in
                    predictVM.resetPrefecture()
                }
                .frame(maxWidth: 410)
            } icon: {
                icon(systemName: "drop.fill", color: .red)
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
    
    private func responseView() -> some View {
        NavigationLink {
            UserResponseView(user: predictVM.user, prefecture: predictVM.prefecture)
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
            favoritePrefectureVM.addToFavorite(prefecture: predictVM.prefecture)
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
        UserRequestView()
            .environmentObject(UserViewModel())
    }
}
