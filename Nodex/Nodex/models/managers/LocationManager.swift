//
//  LocationManager.swift
//  TTGPS
//
//  Created by Alikadev on 22.05.23.
//

import Foundation
import CoreLocation

/*
 Définition du gestionnaire de localisation
 */
class LocationManager: NSObject, ObservableObject
{
	static let shared = LocationManager() // Ceci permet de créer une sorte de Singleton
	static let DEFAULT = CLLocation(latitude: 37.334722, longitude: -122.008889)
	
	private let manager = CLLocationManager()
	@Published var location: CLLocation = DEFAULT
	
	/*
	 Le constructeur
	 */
	override init()
	{
		super.init()
		// Settings du manager
		manager.delegate = self
		manager.desiredAccuracy = kCLLocationAccuracyBest
		manager.startUpdatingLocation()
	}
	
	// Demmande l'autorisation à l'utilisateur
	func requestLocation()
	{
		manager.requestWhenInUseAuthorization()
	}
}

/*
 Ajout d'extentions
 */
extension LocationManager: CLLocationManagerDelegate
{
	// Quand l'autorisation change
	func locationManager(
		_ manager: CLLocationManager,
		didChangeAuthorization status: CLAuthorizationStatus)
	{
		/*
		 Vérifier l'état
		 */
		switch status
		{
		case .notDetermined:
			print("DEBUG: Not determined")
		case .restricted:
			print("DEBUG: Restricted")
		case .denied:
			print("DEBUG: Denied")
		case .authorizedAlways:
			print("DEBUG: Autorization Always")
		case .authorizedWhenInUse:
			print("DEBUG: Autorization In Use")
		@unknown default:
			break
		}
	}
	
	// Quand la localisation change
	func locationManager(
		_ manager: CLLocationManager,
		didUpdateLocations locations: [CLLocation])
	{
		// Définit la nouvelle localisation
		guard let location = locations.last else { return }
		self.location = location
		print("Location changed: ",location.coordinate.longitude,location.coordinate.latitude)
	}
}

