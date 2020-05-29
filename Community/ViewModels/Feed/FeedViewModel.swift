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
	
	func getReports(_ completion: @escaping (Bool)->()) {
		RestAPI.getFeed { response in
			switch response {
			case .success(let feed):
				self.populateFeed(with: feed)
				completion(true)
			case .failure(let e):
				print(e.localizedDescription)
				completion(false)
			}
		}
	}
	
	private func populateFeed(with responseReports: FeedReportsResponse) {
		var rs = [Report]()
		for report in responseReports.reports {
			let r = Report(with: report)
			rs.append(r)
		}
		
		reports.value?.removeAll()
		reports.value = rs
	}
}
