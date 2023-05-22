//
//  ContentView.swift
//  TTGPS
//
//  Created by Alikadev on 22.05.23.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var manager = LocationManager.shared
	
    var body: some View {
        VStack {
			/*
			 Affichage des données
			 */
			VStack {
				/*
				 Longitude
				 */
				HStack {
					Text("Longitude:").fontWeight(.bold)
					Text(String(manager.userLocation?.coordinate.longitude ?? Double.nan))
					Spacer() // Affichage
				}
				/*
				 Latitude
				 */
				HStack {
					Text("Latitude:").fontWeight(.bold)
					Text(String(manager.userLocation?.coordinate.latitude ?? Double.nan))
					Spacer() // Affichage
				}
			}
			.padding() // Affichage
			.padding(.bottom,40) // Affichage
			
			/*
			 Le boutton
			 */
			Button {
				LocationManager.shared.requestLocation()
			} label: {
				/*
				 Le label
				 */
				Text("Request location")
					.padding() // Affichage...
					.background(Rectangle()
						.foregroundColor(Color(.systemBlue))
						.cornerRadius(20))
					.foregroundColor(.white)
					.fontWeight(.bold)
			}
        }
		.font(.system(size: 20))
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
