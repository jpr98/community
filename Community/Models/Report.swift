//
//  Report.swift
//  Community
//
//  Created by Juan Pablo Ramos on 10/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

enum AlertType: Int {
	case crime = 1
	case suspect = 2
	case medic = 3
	
	func getText() -> String {
		switch self {
		case .crime:
			return "Crimen"
		case .suspect:
			return "Sospecha"
		case .medic:
			return "Emergencia Médica"
		}
	}
}

class Report {
	var id: String?
	var type: AlertType?
	var imageURL: String?
	var active: Bool?
	var user: String?
	var description: String?
	
	typealias createReportCompletion = ((_ success: Bool)->())?
	
	func create(completion: createReportCompletion) {
		guard let type = type else {
			completion?(false)
			return
		}
		
		let requestBody = CreateReportRequest(type: type.rawValue, user: User.shared.id, description: description ?? "")
		
		RestAPI.create(body: requestBody) { response in
			switch response {
			case .success(_):
				completion?(true)
			case .failure(_):
				print("error in create report request")
				completion?(false)
			}
		}
	}
}
