//
//  DataManager.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation

class DataManager {
	static var shared = DataManager()
	
	private var root = Node("ROOT", childs: [
		Node("Test1"),
		Node("Test2")
	])
	private let disk = DiskManager()
	private let NODES_KEY = "NODES"
	
	private init()
	{
		if !loadFromDisk() {
			print("Fail to load from disk...")
		}
	}
	
	func loadFromDisk() -> Bool
	{
		do {
			root = try disk.load(type: Node.self, key: NODES_KEY) as! Node
			return true
		} catch ApplicationError.diskError(let message) {
			print(message)
		} catch {
			print("Internal error!")
		}
		return false
	}
	
	func getRoot() -> Node
	{
		return root
	}
	
	func setRoot(_ root: Node)
	{
		self.root = root
		
		do {
			try disk.save(root, key: NODES_KEY)
		} catch ApplicationError.diskError(let message) {
			print(message)
		} catch {
			print("Internal error!")
		}
	}
}
