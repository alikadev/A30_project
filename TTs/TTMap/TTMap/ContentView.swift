//
//  ContentView.swift
//  TTMap
//
//  Created by Alikadev on 22.05.23.
//


import SwiftUI
import MapKit

/*
 Liste des constantes du programme
 */
let ORG_LONGITUDE = 46.793978
let ORG_LATITUDE = 7.157337
let ORG_SCALE: Double = 50

/*
 Définition d'un lieu identifiable. Ceci permet de définit un lieu
 */
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

/*
 Ceci est la vue
 */
struct ContentView: View {
	/*
	 Les lieu avec un marker
	 */
	@State var places: [IdentifiablePlace] = [
		IdentifiablePlace(lat: 46.793978, long: 7.157337), // EMF
		IdentifiablePlace(lat: 46.6025247, long: 7.1026189) // Broc
	]
	/*
	 La région de base
	 */
	@State var region = MKCoordinateRegion(
		center: CLLocationCoordinate2DMake(ORG_LONGITUDE, ORG_LATITUDE),
		latitudinalMeters: CLLocationDistance(floatLiteral: ORG_SCALE),
		longitudinalMeters: CLLocationDistance(floatLiteral: ORG_SCALE))
	
    var body: some View {
		/*
		 La map et ses markers
		 */
		Map(coordinateRegion: $region,
			annotationItems: places)
		{ place in // Comment afficher les markers
			MapMarker(coordinate: place.location, tint: .green)
		}
		.ignoresSafeArea() // Permet de dessiner dans les lieu réservé au système
    }
}

/*
 Juste pour la Preview Xcode. Ceci n'est pas utile
 */
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
