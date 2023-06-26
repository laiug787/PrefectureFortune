//
//  UserRequestView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/26
//

import SwiftUI

struct UserRequestView: View {
    @State private var user: User = User.preview
    @State private var prefecture: Prefecture? = nil
    private var prefectureFetcher = PrefectureFetcher()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Your Information") {
                    Grid {
                        GridRow {
                            Image(systemName: "person")
                                .foregroundColor(.blue)
                            HStack {
                                TextField("Name", text: $user.name)
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(.tertiary)
                                    .foregroundColor(.primary)
                                    .onTapGesture {
                                        user.name = ""
                                    }
                            }
                            .gridColumnAlignment(.leading)
                            .gridCellColumns(2)
                        }
                        Divider().padding(.top, 7)
                        GridRow {
                            Image(systemName: "birthday.cake")
                                .foregroundColor(.orange)
                            DatePicker("Birthday", selection: $user.birthday.date, displayedComponents: .date)
                                .gridCellColumns(2)
                        }
                        GridRow {
                            Image(systemName: "drop")
                                .foregroundColor(.red)
                            Text("Blood Type")
                            Picker("Blood type", selection: $user.bloodType) {
                                ForEach(BloodType.allCases) { type in
                                    Text(type.rawValue.uppercased())
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                }
                
                Section {
                    NavigationLink {
                        if let prefecture = prefecture {
                            UserResponseView(user: user, prefecture: prefecture)
                        } else {
                            Text("nil")
                        }
                    } label: {
                        HStack(spacing: 20) {
                            AsyncImage(url: URL(string: prefecture?.logoUrl ?? Prefecture.preview.logoUrl)) { image in
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
                                Text(prefecture?.name ?? "Japan")
                                    .font(.title)
                                Text(prefecture?.capital ?? "Tokyo")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .redacted(reason: prefecture == nil ? .placeholder : [])
                        }
                    }
                    .disabled(prefecture == nil)
                } header: {
                    Text("Recommended Prefecture")
                } footer: {
                    Text("We will find the best prefectures for you from all over Japan.")
                }
            }
            .navigationTitle("Predict For You")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                predict()
            }
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Button(action: resetPredict) {
                            Label("Reset", systemImage: "arrow.triangle.2.circlepath")
                        }
                        .frame(height: 50)
                        .padding(8)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle(radius: 12))
                        .tint(.gray)
                        .shadow(radius: 7)
                        
                        Spacer()
                        
                        Button(action: predict) {
                            Label("Predict", systemImage: "magnifyingglass")
                        }
                        .frame(height: 50)
                        .padding(8)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle(radius: 12))
                        .shadow(radius: 7)
                    }
                }
                .padding()
            }
        }
    }
    
    private func resetPredict() {
        user = User.preview
        prefecture = nil
    }
    
    private func predict() {
        Task {
            do {
                let prefecture = try await prefectureFetcher.fetchPrefectureData(user: user)
                self.prefecture = prefecture
            } catch APIError.invalidURL {
                print("invalid URL")
            } catch APIError.invalidRequest {
                print("invalid request")
            } catch APIError.invalidResponse {
                print("invalid response")
            } catch APIError.invalidEncode {
                print("invalid encode")
            } catch APIError.invalidDecode {
                print("invalid decode")
            }
        }
    }
}


struct UserRequestView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            UserRequestView()
                .tabItem { Label("Predict", systemImage: "magnifyingglass") }
            UserRequestView()
                .tabItem { Label("Predict", systemImage: "magnifyingglass") }
        }
    }
}
