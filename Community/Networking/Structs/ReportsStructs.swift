//
//  ReportsStructs.swift
//  Community
//
//  Created by Juan Pablo Ramos on 10/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

struct CreateReportRequest: Encodable {
	var type: Int
	var user: String
	var description: String
	
	init(type: Int, user: String, description: String) {
		self.type = type
		self.user = user
		self.description = description
	}
	
	enum CodingKeys : String, CodingKey {
        case type = "iType", user = "fkUser", description = "sDescription"
    }
}

struct CreateReportResponse: Decodable {
	var success: Bool
	var report: ReportResponse
}

struct ReportResponse: Decodable {
	var type: Int
	var description: String
	var imageURL: String
	var sendingHelp: Bool
	var user: String
	
	enum CodingKeys : String, CodingKey {
        case type = "iType", user = "fkUser", description = "sDescription", imageURL = "sImageKey", sendingHelp = "bSendingHelp"
    }
}
