//
//  ShowView.swift
//  NodexA30
//
//  Created by Alikadev on 12.06.23.
//

import SwiftUI
import MapKit

class ShowCtrl: ObservableObject
{
	var node: Node?
	@Published var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(),
		span: MKCoordinateSpan(
			latitudeDelta: 0.04,
			longitudeDelta: 0.04))
	
	init(node: Node) {
		self.node = node
		if node.name != ""
		{
			region.center.latitude = node.lat ?? 0
		 	region.center.longitude = node.lon ?? 0
		} else {
			region.center.latitude = node.childs.first?.lat ?? 0
			region.center.longitude = node.childs.first?.lon ?? 0
		}
	}
	
	func getPlaces() -> [Node]
	{
		var places: [Node] = []
		if node != nil && node?.lat != nil
		{
			places.append(node!)
		}
		return places
	}
}
