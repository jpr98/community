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
	
	enum CodingKeys: String, CodingKey {
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
	
	enum CodingKeys: String, CodingKey {
        case type = "iType", user = "fkUser", description = "sDescription", imageURL = "sImageKey", sendingHelp = "bSendingHelp"
    }
}

struct FeedReportsResponse: Decodable {
	var reports: [FeedReportResponse]
	
	enum CodingKeys: String, CodingKey {
		case reports = "reports"
	}
}

struct FeedReportResponse: Decodable {
	var id: String
	var type: Int
	var description: String
	var imageURL: String
	var sendingHelp: String
	
	var user: UserInsideReport
	
	struct UserInsideReport: Decodable {
		var name: String
		var address: String
		
		enum CodingKeys: String, CodingKey {
			case name = "sName", address = "sAddress"
		}
	}
	
	enum CodingKeys: String, CodingKey {
		case id = "_id", type = "iType", description = "sDescription", imageURL = "sImageKey", sendingHelp = "bSendingHelp", user = "fkUser"
	}
}
