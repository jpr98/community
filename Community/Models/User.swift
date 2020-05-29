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
    var altPhone: String
    var isStudent: Bool
    var isActive: Bool
    var colony: String
    var DoB: String
    var createdAt: String
    var updatedAt: String
    var v: Int
    var emergencyC: String
	private var password: String?
	
	typealias authCompletion = ((_ success: Bool)->())
	typealias createCompletion = ((_ user: User)->())
    typealias changeCompletion = ((_ success: Bool)->())
    typealias loadCompletionSuccess = ((_ success: Bool)->())
    typealias loadCompletion = ((_ user: User)->())
    
	
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
    
    
    func change(completion: changeCompletion) {
        
        let requestBodyChange = ChangeProfileRequest(id: self.id, address: self.address, DoB: self.DoB, phone: self.phone, altPhone: self.altPhone, isStudent: self.isStudent, isActive: self.isActive, email: self.email, colony: self.colony, createdAt:self.createdAt , updatedAt: self.updatedAt, v: self.v, emergencyC:emergencyC)
        
        
        RestAPI.create(body: requestBodyChange) { response in
            switch response {
            case .success(_):
                completion?(true)
            case .failure(_):
                print("error in create report request")
                completion?(false)
            }
        }
    }
    
    
    func load(completion: loadCompletionSuccess, completionUser: loadCompletion) {
        
        let requestBodyLoad = LoadProfileRequest(id: self.id)
        
        RestAPI.create(body: requestBodyLoad) { response in
            switch response {
            case .success(_):
                completion(true)
                completionUser?(self)
                
            case .failure(_):
                completion(false)
                print("error in create report request")
            }
        }
    }
    
    
    

	
	func logout() {
		
	}
}
