//
//  API+Endpoints.swift
//  Community
//
//  Created by Juan Pablo Ramos on 22/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

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
	
	class func upload(image: UIImage, to report: Report, completion: @escaping (Bool)->()) {
		guard let id = report.id else {
			completion(false)
			return
		}
		
		uploadImage(.community, path: "/reports/\(id)", paramName: "image", fileName: "img", image: image, completion: completion)
	}
}
