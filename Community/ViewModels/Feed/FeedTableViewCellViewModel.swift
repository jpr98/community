//
//  FeedTableViewCellViewModel.swift
//  Community
//
//  Created by Juan Pablo Ramos on 28/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class FeedTableViewCellViewModel {
	
	var title: String
	var subtitle: String
	var color: UIColor {
		get {
			return UIColor.getCommunity(type.getColor())
		}
	}
	private var type: AlertType
	
	init() {
		title = ""
		subtitle = ""
		type = .crime
	}
	
	init(report: Report) {
		title = report.generateTitle()
		subtitle = report.subtitle()
		type = report.type ?? .crime
	}
}
