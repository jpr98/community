//
//  CreateUserViewModel.swift
//  Community
//
//  Created by Juan Pablo Ramos on 23/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

class CreateUserViewModel {
	
	func create(user: User, completion: @escaping User.createCompletion) {
		user.create(completion)
	}
}
