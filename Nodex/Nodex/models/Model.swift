//
//  Model.swift
//  Nodex
//
//  Created by Alikadev on 06.06.23.
//

import Foundation

class Model
{
	func save()
	{
		DataManager.shared.setRoot(DataManager.shared.root)
	}
	func getRoot() -> Node
	{
		return DataManager.shared.root
	}
	func sortChilds(_ node: Node)
	{
		node.childs = node.childs.sorted {$0.name < $1.name}
	}
}
