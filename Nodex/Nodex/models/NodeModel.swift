//
//  NodeModel.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation

class NodeModel
{
	var data = DataManager.shared
	
	func removeChildNode(node: Node, _ name: String) {
		node.childs = node.childs.filter({$0.name != name})
		
	}
}
