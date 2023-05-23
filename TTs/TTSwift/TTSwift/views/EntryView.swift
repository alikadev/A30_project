//
//  EntryView.swift
//
//  Created by Alikadev on 22.05.23.
//

import SwiftUI

struct EntryView: View {
	@ObservedObject var locationManager = LocationManager.shared
	
	var body: some View {
		
		Group {
			if locationManager.userLocation == nil {
				LocationRequestView()
			} else {
				TTView(place: IdentifiablePlace(
					lat: locationManager.region.center.latitude,
					long: locationManager.region.center.longitude))
			}
		}
	}
}

struct EntryView_Previews: PreviewProvider {
	static var previews: some View {
		EntryView()
	}
}
