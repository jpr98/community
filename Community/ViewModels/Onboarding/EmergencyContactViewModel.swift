//
//  EmergencyContactViewModel.swift
//  Community
//
//  Created by Juan Pablo Ramos on 28/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

class EmergencyContactViewModel {
	
	private var user: User
	var isOB = true
	
	var title: Observable<String>
	var subtitle: Observable<String>
	var secondButtonTitle: String
	
	init(user: User, isOB: Bool) {
		self.user = user
		title = Observable<String>("")
		subtitle = Observable<String>("")
		secondButtonTitle = ""
		self.isOB = isOB
		setup()
	}
	
	func setup() {
		if isOB {
			title.value = "Contacto de emergencia"
			subtitle.value = "Hola \(user.name), este correo será utilizado en caso de que tenga una emergencia. Si desea lo puede hacer más tarde."
			secondButtonTitle = "Saltar"
		} else {
			title.value = "Contacto de emergencia"
			subtitle.value = "Puede actualizar su contacto de emergencia aqui."
			secondButtonTitle = "Regresar"
		}
	}
	
	func addEmergencyContact(email: String, completion: @escaping (Bool)->()) {
		let req = EmergencyContactRequest(contactEmail: email)
		RestAPI.addEmergencyContact(for: user.id, body: req) { response in
			switch response {
			case .success(let msg):
				if msg.message == "Se ha actualizado el usuario" {
					completion(true)
				} else {
					completion(false)
				}
			case .failure(let e):
				print(e.localizedDescription)
				completion(false)
			}
		}
	}
	
}
