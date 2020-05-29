//
//  UserStructs.swift
//  Community
//
//  Created by Juan Pablo Ramos on 28/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

struct CreateUserRequest: Encodable {
	var name: String
	var email: String
	var password: String
	var colony = Community().id
	var address: String
	var phone: String
	var student: Bool
	
	enum CodingKeys: String, CodingKey {
		case name = "sName", email = "sEmail", password = "sPassword", colony = "fkColony", address = "sAddress", phone = "sPhone", student = "bIsStudent"
	}
}

struct CreateUserResponse: Decodable {
	var success: Bool
	
	enum CodingKeys: String, CodingKey {
		case success = "success"
	}
}

struct EmergencyContactRequest: Encodable {
	var contactEmail: String
	
	enum CodingKeys: String, CodingKey {
		case contactEmail = "sEmergencyEmail"
	}
}

struct UpdateUserResponse: Decodable {
	var message: String
	
	enum CodingKeys: String, CodingKey {
		case message = "message"
	}
}

struct WrapperUserResponse: Decodable {
	var user: UserResponse
	
	enum CodingKeys: String, CodingKey {
		case user = "user"
	}
}

struct UserResponse: Decodable {
	var name: String
	var imageURL: String
	var address: String
	
	enum CodingKeys: String, CodingKey {
		case name = "sName", imageURL = "sImgProfileUrl", address = "sAddress"
	}
}
