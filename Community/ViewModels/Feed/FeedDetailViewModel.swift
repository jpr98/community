//
//  FeedDetailViewModel.swift
//  Community
//
//  Created by Juan Pablo Ramos on 29/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

class FeedDetailViewModel {
	
	var title = ""
	var name = ""
	var address = ""
	var description = ""
	private var imageURL = ""
	
	private var report: Report
	
	init(report: Report) {
		self.report = report
		setup()
	}
	
	func setup() {
		guard let type = report.type,
			let name = report.user?.name,
			let address = report.user?.address,
			let description = report.description,
			let imageurl = report.imageURL
		else { return }
		
		title = type.getText()
		if !name.isEmpty {
			self.name = "Enviado por: " + name
		}
		if !address.isEmpty {
			self.address = "Desde: " + address
		}
		if !description.isEmpty {
			self.description = description
		} else {
			self.description = "Sin descripción"
		}
		imageURL = imageurl
		
	}
}
