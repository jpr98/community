//
//  MainAlertsViewModel.swift
//  Community
//
//  Created by Juan Pablo Ramos on 10/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import Foundation

class MainAlertsViewModel {
	
	var crimeButtonText: Observable<String>
	var suspectButtonText: Observable<String>
	var medicButtonText: Observable<String>
	
	init() {
		crimeButtonText = Observable<String>(AlertType.crime.getText())
		suspectButtonText = Observable<String>(AlertType.suspect.getText())
		medicButtonText = Observable<String>(AlertType.medic.getText())
	}
	
	enum AlertStatus: String {
		case sending = "Enviando reporte"
		case successful = "Reporte enviado"
		case failed = "Error enviando reporte"
	}
	
	func createReport(of type: AlertType, _ completion: Report.createReportCompletion = nil) {
		let report = Report()
		report.type = type
		report.user = User.shared.id
		report.description = ""
		
		propertyForType(type).value = AlertStatus.sending.rawValue
		
		report.create { success in
			if success {
				self.propertyForType(type).value = AlertStatus.successful.rawValue
				DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
					self.propertyForType(type).value = type.getText()
				}
			} else {
				self.propertyForType(type).value = AlertStatus.failed.rawValue
			}
			completion?(success)
		}
	}
	
	private func propertyForType(_ type: AlertType) -> Observable<String> {
		switch type {
		case .crime:
			return crimeButtonText
		case .suspect:
			return suspectButtonText
		case .medic:
			return medicButtonText
		}
	}
}
