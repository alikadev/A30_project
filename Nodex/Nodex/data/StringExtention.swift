//
//  StringExtention.swift
//  Nodex
//
//  Created by Alikadev on 05.06.23.
//

import Foundation

extension String {
	var isAlphanumeric: Bool {
		return !isEmpty && range(of: "[^a-zA-Z0-9 -_]", options: .regularExpression) == nil
	}
}
