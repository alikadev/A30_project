//
//  NodeCtrl.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation

class NodeCtrl: RootCtrl {
	var node: Node
	var path: String
	var parent: Node
	private var wrk = NodeModel()
	
	init(_ node: Node, parent: Node, path: String) {
		self.node = node
		self.parent = parent
		self.path = path
	}
	
	func removeNode() {
		wrk.removeChildNode(node: parent, node.name)
		DataManager.shared.debugNode(wrk.data.root)
	}
}
