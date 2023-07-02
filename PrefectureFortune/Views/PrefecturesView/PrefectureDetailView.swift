//
//  PrefectureDetailView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI
import MapKit

struct PrefectureDetailView: View {
    @EnvironmentObject var favoritePersonVM: PersonViewModel
    
    var person: Person? = nil
    var prefecture: Prefecture
    @State private var region = MKCoordinateRegion()
    @State private var isExpanded: Bool = false
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.all)
            ViewThatFits {
                VStack {
                    Spacer(minLength: 0)
                    HStack(alignment: .bottom) {
                        personCard()
                            .padding(16)
                        prefectureCard()
                            .padding(16)
                    }
                }
                VStack {
                    personCard()
                        .padding(16)
                    Spacer()
                    prefectureCard()
                        .padding(16)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                if let person = person {
                    Button("Save") {
                        favoritePersonVM.addToFavorite(person, prefecture)
                    }
                }
            }
        }
        .onAppear {
            let address = prefecture.capital
            CLGeocoder().geocodeAddressString(address) { placemarks, error in
                guard let latitude = placemarks?.first?.location?.coordinate.latitude else { return }
                guard let longitude = placemarks?.first?.location?.coordinate.longitude else { return }
                region = MKCoordinateRegion(
                    center : CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                    latitudinalMeters: 5000.0,
                    longitudinalMeters: 5000.0
                )
            }
        }
    }
    
    private func prefectureCard() -> some View {
        VStack {
            PrefectureListItem(prefecture)
                .frame(minWidth: 300)
            Divider()
            if isExpanded {
                Text(prefecture.brief)
            } else {
                Text("Show more")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(height: 25)
            }
        }
        .glassCardStyle()
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
    
    private func personCard() -> some View {
        Group {
            if let person = person {
                PersonListItem(person)
                    .glassCardStyle()
            }
        }
    }
}

struct PrefectureDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            NavigationStack {
                PrefectureDetailView(prefecture: samplePrefectures[1])
            }
        }
        .environmentObject(PersonViewModel())
    }
}
