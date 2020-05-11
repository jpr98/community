//
//  AlertDetailViewController.swift
//  Community
//
//  Created by Juan Pablo Ramos on 10/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class AlertDetailViewController: UIViewController {
	
	static func make() -> AlertDetailViewController {
		return UIStoryboard(name: "Alerts", bundle: nil).instantiateViewController(identifier: identifier) as! AlertDetailViewController
	}
	
	static let identifier = "AlertDetail"
	
	@IBOutlet weak var closeButton: UIButton!
	
	var alertType: AlertType = .suspect
	private let transition = CircularTransition()
	
	override func viewDidLoad() {
		if alertType == .suspect {
			view.backgroundColor = UIColor.getCommunity(.orange)
		} else if alertType == .crime {
			view.backgroundColor = UIColor.getCommunity(.yellow)
		} else if alertType == .medic {
			view.backgroundColor = UIColor.getCommunity(.lightBlue)
		}
	}
	
	@IBAction func closeButtonTapped(_ sender: Any) {
		
	}
	
}

extension UIViewController {
	func showAlertDetailVC(alertType: AlertType, transitionDelegate delegate: UIViewControllerTransitioningDelegate) {
		let vc = AlertDetailViewController.make()
		vc.alertType = alertType
		vc.transitioningDelegate = delegate
		vc.modalPresentationStyle = .custom
		present(vc, animated: true, completion: nil)
	}
}
