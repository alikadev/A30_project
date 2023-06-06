//
//  Node.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation
import MapKit

class Node : Codable, Identifiable
{
	final var name: String
	var content: String?
	var lon: Double?
	var lat: Double?
	var childs: [Node]
	
	init(_ name: String,
		 content: String? = nil,
		 coord: CLLocation? = nil,
		 childs: [Node] = [])
	{
		self.name = name
		self.content = content
		self.lon = coord?.coordinate.longitude
		self.lat = coord?.coordinate.latitude
		self.childs = childs
	}
	
	init(node: Node)
	{
		self.name = node.name
		self.content = node.content
		self.lon = node.lon
		self.lat = node.lat
		childs = []
		for child in node.childs {
			childs.append(Node(node: child))
		}
	}
}
