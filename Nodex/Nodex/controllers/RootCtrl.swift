//
//  RootCtrl.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation

class RootCtrl
{
	var model = RootModel()
	func loadNodes()
	{
		model.loadNodes()
	}
	
	func getRootNode() -> Node
	{
		return model.getRootNode()
	}
	
}
