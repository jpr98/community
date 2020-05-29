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
	
	class func createUser(body: CreateUserRequest, done: @escaping Response<CreateUserResponse>) {
		request(.community, path: "/users", method: .POST, body: body, done: done)
	}
	
	class func addEmergencyContact(for id: String, body: EmergencyContactRequest, done: @escaping Response<UpdateUserResponse>) {
		request(.community, path: "/users/\(id)", method: .PUT, done: done)
	}
	
	// MARK: - Reports
	class func create(body: CreateReportRequest, done: @escaping Response<CreateReportResponse>) {
		request(.community, path: "/reports", method: .POST, body: body, done: done)
	}
	
	class func getFeed(done: @escaping Response<FeedReportsResponse>) {
		request(.community, path: "/reports", method: .GET, done: done)
	}
}
