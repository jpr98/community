//
//  FeedViewModel.swift
//  Community
//
//  Created by Juan Pablo Ramos on 28/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

class FeedViewModel {
	
	var reports: Observable<[Report]>
	
	init() {
		reports = Observable<[Report]>([])
	}
	
	init(reports: [Report]) {
		self.reports = Observable<[Report]>(reports)
	}
	
	func getReports() {
		// make request
	}
}
