//
//  RootModel.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation

class RootModel
{
	private var data = DataManager.shared
	
	func loadNodes()
	{
		if !data.loadFromDisk() {
			print("Fail to load from disk...")
		}
	}
	
	func getRootNode() -> Node
	{
		return data.getRoot()
	}
}
