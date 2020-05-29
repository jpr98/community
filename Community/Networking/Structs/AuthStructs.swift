//
//  AuthStructs.swift
//  Community
//
//  Created by Juan Pablo Ramos on 22/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

struct AuthRequest: Encodable {
	var email: String
	var password: String
	
	init(email: String, password: String) {
		self.email = email
		self.password = password
	}
	
	enum CodingKeys : String, CodingKey {
        case email = "sEmail", password = "sPassword"
    }
}

struct AuthResponse: Decodable {
	var success: Bool
	var token: String
	var user: AuthUser
	
	struct AuthUser: Decodable {
		var id: String
		
		enum CodingKeys : String, CodingKey {
			case id = "_id"
		}
	}
	
	enum CodingKeys : String, CodingKey {
        case success = "success", token = "token", user = "user"
    }
}
