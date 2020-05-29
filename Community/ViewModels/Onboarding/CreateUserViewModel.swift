//
//  CreateUserViewModel.swift
//  Community
//
//  Created by Juan Pablo Ramos on 23/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

class CreateUserViewModel {
	
	private var email: String
	private var password: String
	
	init(for user: User) {
		email = user.email
		password = user.password ?? ""
	}
	
	func create(request: CreateUserRequest, _ completion: @escaping User.createCompletion) {
		var req = request
		req.email = email
		req.password = password
		
		User.create(req) { success in
			guard success else {
				completion(false)
				return
			}
			
			let request = AuthRequest(email: self.email, password: self.password)
			User.authenticate(request) { success in
				completion(success)
			}
		}
	}
}
