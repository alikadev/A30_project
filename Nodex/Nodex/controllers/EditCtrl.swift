//
//  EditView.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation
import CoreLocation
import MapKit

class EditCtrl: ObservableObject
{
	var parent: Node?
	var node: Node?
	let model = EditModel()
	@Published var region = MKCoordinateRegion(
		center: CLLocationCoordinate2D(),
		span: MKCoordinateSpan(
			latitudeDelta: 0.04,
			longitudeDelta: 0.04))
	
	init(parent: Node) {
		self.parent = parent
		node = nil
		
		region.center = model.getLocation().coordinate
	}
	
	init(node: Node)
	{
		parent = nil
		self.node = node
		
		region.center = model.getLocation().coordinate
	}
	
	func createNode(_ name: String,
					content: String? = nil)
	{
		if parent != nil
		{
			let n = Node(name, content: content, coord: model.getLocation())
			model.replaceNode(parent: parent!, node: n)
			model.sortChilds(parent!)
		} else if node != nil {
			node?.name = name
			node?.content = content
			node?.lon = model.getLocation().coordinate.longitude
			node?.lat = model.getLocation().coordinate.latitude
		}
		model.save()
	}
	
}
