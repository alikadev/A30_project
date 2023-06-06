//
//  EditView.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation
import CoreLocation

class EditCtrl
{
	var parent: Node
	let model = EditModel()
	init(_ parent: Node) {
		self.parent = parent
	}
	
	func createNode(_ name: String,
					content: String? = nil,
					lon: Double? = nil,
					lat: Double? = nil)
	{
		var n: Node
		if lon != nil && lat != nil {
			n = Node(name, content: content, coord: CLLocation(latitude: lat!, longitude: lon!))
		} else {
			n = Node(name, content: content)
		}
		model.replaceNode(parent: parent, node: n)
		model.sortChilds(parent)
		model.save()
		
	}
}
