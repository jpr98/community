//
//  LoginViewModel.swift
//  Community
//
//  Created by Juan Pablo Ramos on 21/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

class LoginViewModel {
	
	var usecase: LoginUseCase = .login
	var title: Observable<String>
	var subtitle: Observable<String>
	var changeButtonTitle: Observable<String>
	
	init(usecase: LoginUseCase) {
		self.usecase = usecase
		title = Observable<String>("")
		subtitle = Observable<String>("")
		changeButtonTitle = Observable<String>("")
		setup()
	}
	
	func setup() {
		if usecase == .login {
			title.value = "Log in"
			subtitle.value = """
			Welcome back to Community!
			Please enter your credentials
			"""
			changeButtonTitle.value = "Create account"
		} else {
			title.value = "Sign up"
			subtitle.value = """
			We are thrilled to have you join Community!
			Please enter your email and new password
			"""
			changeButtonTitle.value = "I have an account"
		}
	}
	
	func changeUsecase() {
		usecase.toggle()
		setup()
	}
	
	func authenticate(with email: String, and password: String, _ completion: @escaping User.authCompletion) {
		let authRequest = AuthRequest(email: email, password: password)
		User.authenticate(authRequest, completion: completion)
	}
	
	func create(for email: String, with password: String, _ completion: @escaping User.createCompletion) {
		#warning("fix this")
		let user = User(email: email, password: password)
		completion(user)
	}
	
}

enum LoginUseCase {
	case login
	case signup
	
	mutating func toggle() {
		if self == LoginUseCase.login {
			self = LoginUseCase.signup
		} else {
			self = LoginUseCase.login
		}
	}
}
