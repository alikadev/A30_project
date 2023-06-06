//
//  DataManager.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation

class DataManager: ObservableObject
{
	static var shared = DataManager()
	static let DEFAULT = Node("")
	
	private let NODES_KEY = "NODES"
	@Published var root = Node(node: DEFAULT)
	private let disk = DiskManager()
	
	private init()
	{
		if !loadFromDisk() {
			setRoot(root)
		}
	}
	
	func debugNode(_ node: Node, indent: Int = 0)
	{
		var spaces = ""
		for _ in 0 ... indent {
			spaces += "  "
		}
		print(spaces + "[" + node.name + "]")
		for child in node.childs {
			debugNode(child, indent: indent+1)
		}
	}
	
	func loadFromDisk() -> Bool
	{
		do {
			root = try disk.load(type: Node.self, key: NODES_KEY) as! Node
			return true
		} catch ApplicationError.diskError(let message) {
			print("loadFromDisk: "+message)
		} catch {
			print("loadFromDisk: Unreachable")
		}
		return false
	}
	
	func setRoot(_ root: Node)
	{
		self.root = root
		
		do {
			try disk.save(root, key: NODES_KEY)
		} catch ApplicationError.diskError(let message) {
			print("setRoot: "+message)
		} catch {
			print("setRoot: Unreachable")
		}
	}
}
