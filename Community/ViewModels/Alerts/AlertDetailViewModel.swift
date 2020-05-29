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
	private var report: Report?
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
	
	func createReport(with description: String, _ image: UIImage? = nil, _ completion: Report.createReportCompletion = nil) {
		let report = Report()
		report.type = type
		report.description = description
		
		sendButtonText.value = AlertStatus.sending.rawValue
		
		report.create { (success, report) in
			if success {
				self.sendButtonText.value = AlertStatus.successful.rawValue
				self.report = Report()
				self.report?.id = report?.id
				
				if let img = image {
					RestAPI.upload(image: img, to: self.report!, completion: { _ in
						
					})
				}
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					completion?(success, report)
				}
			} else {
				self.sendButtonText.value = AlertStatus.failed.rawValue
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					self.sendButtonText.value = AlertStatus.normal.rawValue
					completion?(success, report)
				}
			}
		}
	}
	
	func uploadImage(_ image: UIImage, _ completion: @escaping (Bool)->()) {
		guard let report = report else {
			completion(false)
			return
		}
		RestAPI.upload(image: image, to: report, completion: completion)
	}
}
