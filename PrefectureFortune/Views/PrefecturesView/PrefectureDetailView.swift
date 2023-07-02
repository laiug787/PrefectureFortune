//
//  PrefectureDetailView.swift
//  PrefectureFortune
//
//  Created by Yusho Segawa on 2023/06/27
//

import SwiftUI
import MapKit

struct PrefectureDetailView: View {
    var prefecture: Prefecture
    @State private var region = MKCoordinateRegion()
    @State private var isExpanded: Bool = false
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.vertical)
            VStack {
                HStack {
                    Spacer()
                    Button {
                        print("")
                    } label: {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 30.0, height: 30.0)
                            .padding()
                    }
                    .tint(.yellow)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                    .compositingGroup()
                    .shadow(radius: 4)
                    .padding()
                }
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
                .padding(16)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                .frame(minWidth: 90, maxWidth: 350)
                .padding(16)
                .compositingGroup()
                .shadow(radius: 8)
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
            }
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
