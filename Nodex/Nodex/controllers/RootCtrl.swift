//
//  RootCtrl.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation

class RootCtrl: ObservableObject
{
	private var model = RootModel()
	func loadNodes()
	{
		model.loadNodes()
	}
	
	func reset()
	{
		DataManager.shared.setRoot(DataManager.DEFAULT)
		print("Data are reseted")
		DataManager.shared.debugNode(getRootNode())
	}
	
	func getRootNode() -> Node
	{
		return model.data.root
	}
	
}
