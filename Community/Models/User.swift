//
//  User.swift
//  Community
//
//  Created by Juan Pablo Ramos on 21/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

class User {
	var id: String
	var name: String
	var lastname: String
	var email: String
	var token: String?
	var community: Community
	var address: String
	var phone: String
	private var password: String?
	
	typealias authCompletion = ((_ success: Bool)->())
	typealias createCompletion = ((_ user: User)->())
	
	static var shared = User()
	
	init() {
		id = ""
		name = ""
		lastname = ""
		email = ""
		community = Community(id: "sdf")
		address = ""
		phone = ""
		token = UserDefaults.standard.string(forKey: "token")
	}
	
	init(email: String, password: String) {
		id = ""
		name = ""
		lastname = ""
		self.email = email
		community = Community(id: "sdf")
		address = ""
		phone = ""
		self.password = password
	}
	
	init(id: String, name: String, lastname: String, email: String, token: String, community: Community, address: String, phone: String) {
		self.id = id
		self.name = name
		self.lastname = lastname
		self.email = email
		self.token = token
		self.community = community
		self.address = address
		self.phone = phone
	}
	
	static func authenticate(_ auth: AuthRequest, completion: @escaping authCompletion) {
		RestAPI.auth(body: auth) { response in
			switch response {
			case .success(let auth):
				UserDefaults.standard.set(auth.token, forKey: "token")
				UserDefaults.standard.set(true, forKey: "user_loggedin")
				shared.token = auth.token
				shared.id = auth.user.id
				completion(true)
			case .failure(let e):
				print(e.localizedDescription)
				completion(false)
			}
		}
	}
	
	func create(_ completion: @escaping createCompletion) {
		UserDefaults.standard.set(true, forKey: "user_loggedin")
		completion(self)
	}
	
	func logout() {
		
	}
}
