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
	var email: String
	var token: String?
	var community: Community
	var address: String
	var phone: String
	var password: String?
	var student: Bool
	var imageURL = ""
	
	typealias authCompletion = ((_ success: Bool)->())
	typealias createCompletion = ((_ user: Bool)->())
	
	static var shared = User()
	
	init() {
		id = ""
		name = ""
		email = ""
		community = Community()
		address = ""
		phone = ""
		token = UserDefaults.standard.string(forKey: "token")
		student = false
	}
	
	init(email: String, password: String) {
		id = ""
		name = ""
		self.email = email
		community = Community()
		address = ""
		phone = ""
		self.password = password
		student = false
	}
	
	init(name: String, address: String) {
		id = ""
		self.name = name
		email = ""
		community = Community()
		self.address = address
		phone = ""
		token = UserDefaults.standard.string(forKey: "token")
		student = false
	}
	
	init(id: String, name: String, email: String, token: String, community: Community, address: String, phone: String, student: Bool) {
		self.id = id
		self.name = name
		self.email = email
		self.token = token
		self.community = community
		self.address = address
		self.phone = phone
		self.student = student
	}
	
	func populate() {
		if let id = UserDefaults.standard.string(forKey: "user_id") {
			RestAPI.getUser(with: id) { response in
				switch response {
				case .success(let u):
					self.name = u.user.name
					self.address = u.user.address
					self.imageURL = u.user.imageURL
				case .failure(let e):
					print(e.localizedDescription)
				}
			}
		}
	}
	
	static func authenticate(_ auth: AuthRequest, completion: @escaping authCompletion) {
		RestAPI.auth(body: auth) { response in
			switch response {
			case .success(let auth):
				UserDefaults.standard.set(auth.token, forKey: "token")
				UserDefaults.standard.set(true, forKey: "user_loggedin")
				UserDefaults.standard.set(auth.user.id, forKey: "user_id")
				shared.token = auth.token
				shared.id = auth.user.id
				completion(true)
			case .failure(let e):
				print(e.localizedDescription)
				completion(false)
			}
		}
	}
	
	static func create(_ request: CreateUserRequest, _ completion: @escaping createCompletion) {
		RestAPI.createUser(body: request) { response in
			switch response {
			case .success(let r):
				if r.success {
					shared.name = request.name
					shared.email = request.email
					shared.address = request.address
					shared.phone = request.phone
					shared.community = Community()
					completion(true)
				} else {
					print("Server couldn't create user")
					completion(false)
				}
			case .failure(let e):
				print(e.localizedDescription)
				completion(true)
			}
		}
	}
	
	func logout() {
		
	}
}
