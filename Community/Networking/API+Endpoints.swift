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
	
	// MARK: - Reports
	class func create(body: CreateReportRequest, done: @escaping Response<CreateReportResponse>) {
		request(.community, path: "/reports", method: .POST, body: body, done: done)
	}
    
    class func getProfile(body: LoadProfileRequest, done: @escaping Response<LoadProfileResponse>){
        request(.community, path:"/users", method: .GET, body:body, done: done)
    }
    
    class func saveProfile(body: ChangeProfileRequest, done: @escaping Response<ChangeProfileResponse>){
        request(.community, path:"/users", method: .PUT, body:body, done: done)
    }

}
