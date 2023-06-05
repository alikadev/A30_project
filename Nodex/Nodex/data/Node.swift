//
//  Node.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation
import MapKit

class Node : Encodable, Decodable, Identifiable
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
}
