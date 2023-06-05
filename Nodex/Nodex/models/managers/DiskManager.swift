//
//  DIskManager.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation

class DiskManager {
	/*
	 Sauvegarde un objet Encodable.
	 */
	public func save(_ object: any Encodable, key: String) throws
	{
		let defaults = UserDefaults.standard
		
		do {
			let data = try JSONEncoder().encode(object)
			defaults.set(data, forKey: key)
		} catch {
			throw ApplicationError.diskError("Cannot persist data in disk")
		}
	}
	
	/*
	 Charge un objet depuis le disque
	 */
	public func load(type: any Decodable.Type ,key: String) throws -> Decodable
	{
		let defaults = UserDefaults.standard
		
		do {
			if let data = defaults.object(forKey: key)
			{
				return try JSONDecoder().decode(type, from: data as! Foundation.Data)
			}
		} catch {
			throw ApplicationError.diskError("Cannot decode data")
		}
		throw ApplicationError.diskError("No data at key index")
	}
}
