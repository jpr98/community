//
//  API+Endpoints.swift
//  Community
//
//  Created by Juan Pablo Ramos on 22/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

extension RestAPI {
	// MARK: - Users
	class func auth(body: AuthRequest, done: @escaping Response<AuthResponse>) {
		request(.community, path: "/auth", method: .POST, body: body, done: done)
	}
	
}
