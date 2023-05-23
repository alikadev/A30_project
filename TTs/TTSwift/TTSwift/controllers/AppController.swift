//
//  TTViewController.swift
//  Swift VS React
//
//  Created by Alikadev on 22.05.23.
//

import Foundation
import CoreLocation

class TTViewController {
	struct keys
	{
		static let LONGITUDE = "longitude"
		static let LATITUDE = "latitude"
	}
	public func saveLocation(lon: Double, lat: Double) -> Void
	{
		let defaults = UserDefaults.standard
		
		defaults.set(lon, forKey: keys.LONGITUDE)
		defaults.set(lat, forKey: keys.LATITUDE)
	}
	public func loadLocation() -> CLLocationCoordinate2D
	{
		var loc = CLLocationCoordinate2D()
		let defaults = UserDefaults.standard
		
		loc.longitude = defaults.double(forKey: keys.LONGITUDE)
		loc.latitude = defaults.double(forKey: keys.LATITUDE)
		
		return loc
	}
}
