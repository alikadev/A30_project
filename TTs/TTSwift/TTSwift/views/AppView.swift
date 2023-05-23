//
//  TTView.swift
//  Swift VS React
//
//  Created by Alikadev on 22.05.23.
//

import SwiftUI
import MapKit

struct IdentifiablePlace: Identifiable {
	let id: UUID
	var location: CLLocationCoordinate2D
	init(id: UUID = UUID(), lat: Double, long: Double) {
		self.id = id
		self.location = CLLocationCoordinate2D(
			latitude: lat,
			longitude: long)
	}
}

struct TTView: View {
	@ObservedObject var locationManager = LocationManager.shared
	@State var place: IdentifiablePlace
	let ctrl = TTViewController()
	
	var body: some View {
		VStack {
			Map(coordinateRegion: $locationManager.region,
				annotationItems: [place])
			{ place in
				MapMarker(
					coordinate: place.location,
					tint: Color.purple)
			}
			.ignoresSafeArea()
			Spacer()
			
			HStack {
				Button {
					ctrl.saveLocation(
						lon: place.location.longitude,
						lat: place.location.latitude)
				} label: {
					Text("Save location")
				}
				.padding()
				.background(Rectangle()
					.foregroundColor(Color(.systemBlue))
					.cornerRadius(10)
					.padding(10))
				.foregroundColor(.white)
				
				Button {
					place.location = ctrl.loadLocation()
				} label: {
					Text("Load location")
				}
				.padding()
				.background(Rectangle()
					.foregroundColor(Color(.systemBlue))
					.cornerRadius(10)
					.padding(10))
				.foregroundColor(.white)
				
				Button {
					place.location = locationManager.region.center
				} label: {
					Text("Set new location")
				}
				.padding()
				.background(Rectangle()
					.foregroundColor(Color(.systemBlue))
					.cornerRadius(10)
					.padding(10))
				.foregroundColor(.white)
			}
		}
	}
}

struct TTView_Previews: PreviewProvider {
	static var previews: some View {
		TTView(place: IdentifiablePlace(lat: 0, long: 0))
	}
}
