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
			title.value = "Iniciar sesión"
			subtitle.value = """
			Bienvenido de vuelta a Community!
			Por favor ingrese sus credenciales
			"""
			changeButtonTitle.value = "Crear una cuenta"
		} else {
			title.value = "Registrarse"
			subtitle.value = """
			Estamos muy emocionados de que se una a Community!
			Por favor ingrese un correo y contraseña
			"""
			changeButtonTitle.value = "Ya tengo una cuenta"
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
