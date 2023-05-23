//
//  LocationManager.swift
//  Swift VS React
//
//  Created by Alikadev on 20.05.23.
//

import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject
{
	private let manager = CLLocationManager()
	@Published var userLocation: CLLocation?
	static let shared = LocationManager()
	@Published var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(),
		span: MKCoordinateSpan(
			latitudeDelta: 0.5,
			longitudeDelta: 0.5))
	
	override init()
	{
		super.init()
		manager.delegate = self
		manager.desiredAccuracy = kCLLocationAccuracyBest
		manager.startUpdatingLocation()
	}
	
	func requestLocation()
	{
		manager.requestWhenInUseAuthorization()
	}
}


extension LocationManager: CLLocationManagerDelegate
{
	func locationManager(
		_ manager: CLLocationManager,
		didChangeAuthorization status: CLAuthorizationStatus)
	{
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
	
	func locationManager(
		_ manager: CLLocationManager,
		didUpdateLocations locations: [CLLocation])
	{
		guard let location = locations.last else { return }
		self.region.center = location.coordinate
		self.userLocation = location
	}
}
