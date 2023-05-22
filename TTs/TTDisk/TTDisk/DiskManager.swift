//
//  DiskManager.swift
//  TTDisk
//
//  Created by Alikadev on 22.05.23.
//

import Foundation

class DiskManager {
	/*
	 Sauvegarde un objet Encodable.
	 */
	public func save(_ object: any Encodable, key: String) -> Bool
	{
		// Espace disque de base
		let defaults = UserDefaults.standard
		
		do {
			// Encoder la donnée
			let data = try JSONEncoder().encode(object)
			// Ecrire la donnée
			defaults.set(data, forKey: key)
			return true
		} catch {
			return false
		}
	}
	
	/*
	 Charge un objet depuis le disque
	 */
	public func load(type: any Decodable.Type ,key: String) -> (Bool, Decodable?)
	{
		// Espace disque de base
		let defaults = UserDefaults.standard
		
		do {
			// Récupère l'objet
			if let data = defaults.object(forKey: key)
			{
				// Décode l'objet
				return (true, try JSONDecoder().decode(type, from: data as! Foundation.Data))
			}
			return (false, nil)
		} catch {
			return (false, nil)
		}
	}
}
