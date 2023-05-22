//
//  DataStruct.swift
//  TTDisk
//
//  Created by Alikadev on 22.05.23.
//

import Foundation

struct PersonnalData : Encodable, Decodable {
	var name: String
	var id: UUID
	var comment: String
	
	/*
	 Le constructeur
	 */
	init(id: UUID = UUID(), name: String, comment: String = "") {
		self.name = name
		self.id = id
		self.comment = comment
	}
}
