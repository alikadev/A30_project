//
//  EditModel.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation
import CoreLocation

class EditModel: Model
{
	func replaceNode(parent: Node, node: Node)
	{
		parent.childs = parent.childs.filter({$0.name != node.name})
		parent.childs.append(node)
	}
	
	func getLocation() -> CLLocation
	{
		return LocationManager.shared.location
	}
}
