//
//  PrefectureDetailView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI
import MapKit

struct PrefectureDetailView: View {
    var person: Person? = nil
    var prefecture: Prefecture
    @State private var region = MKCoordinateRegion()
    @State private var isExpanded: Bool = false
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.vertical)
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.clear)
                    .background(.ultraThinMaterial, in: Rectangle())
                    .frame(height: 70)
            }
            .edgesIgnoringSafeArea(.vertical)
            VStack {
                Spacer()
                VStack {
                    PrefectureListItem(prefecture)
                    Divider()
                    if isExpanded {
                        Text(prefecture.brief)
                    } else {
                        Text("Show more")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .glassCardStyle()
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                if let person = person {
                    VStack {
                        PersonListItem(person)
                    }
                    .glassCardStyle()
                }
            }
            .padding(16)
        }
        .navigationBarTitleDisplayMode(.inline)
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
}

struct PrefectureDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PrefectureDetailView(prefecture: samplePrefectures[1])
        }
    }
}
