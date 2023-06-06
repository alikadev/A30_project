//
//  RootModel.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation

class RootModel: Model
{
	func loadNodes()
	{
		if !DataManager.shared.loadFromDisk() {
			print("Fail to load nodes from disk...")
		}
	}
	func requestLocation()
	{
		LocationManager.shared.requestLocation()
	}
}
