//
//  AlertDetailViewModel.swift
//  Community
//
//  Created by Juan Pablo Ramos on 11/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class AlertDetailViewModel {
	
	private var type: AlertType
	var sendButtonText: Observable<String>
	var viewColor: UIColor {
		get {
			switch type {
			case .suspect:
				return UIColor.getCommunity(.orange)
			case .crime:
				return UIColor.getCommunity(.yellow)
			case .medic:
				return UIColor.getCommunity(.lightBlue)
			}
		}
	}
	
	init(type: AlertType) {
		self.type = type
		sendButtonText = Observable<String>(AlertStatus.normal.rawValue)
	}
	
	enum AlertStatus: String {
		case normal = "Enviar"
		case sending = "Enviando..."
		case successful = "Listo!"
		case failed = "Error"
	}
	
	func createReport(with description: String, _ completion: Report.createReportCompletion = nil) {
		let report = Report()
		report.type = type
		report.description = description
		
		sendButtonText.value = AlertStatus.sending.rawValue
		
		report.create { success in
			if success {
				self.sendButtonText.value = AlertStatus.successful.rawValue
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					completion?(success)
				}
			} else {
				self.sendButtonText.value = AlertStatus.failed.rawValue
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					self.sendButtonText.value = AlertStatus.normal.rawValue
					completion?(success)
				}
			}
		}
	}
}
