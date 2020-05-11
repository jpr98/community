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
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var descriptionTextView: UITextView!
	@IBOutlet weak var addImageButton: UIButton!
	@IBOutlet weak var sendButton: UIButton!
	
	var alertType: AlertType = .suspect
	let transition = CircularTransition()
	
	override func viewDidLoad() {
		configureUI()
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tap)
		
//		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	func configureUI() {
		closeButton.roundCorners(to: closeButton.frame.height / 2)
		if alertType == .suspect {
			view.backgroundColor = UIColor.getCommunity(.orange)
		} else if alertType == .crime {
			view.backgroundColor = UIColor.getCommunity(.yellow)
		} else if alertType == .medic {
			view.backgroundColor = UIColor.getCommunity(.lightBlue)
		}
		
		addImageButton.backgroundColor = UIColor.getCommunity(.darkBlue)
		addImageButton.roundCorners(to: addImageButton.frame.height / 2)
		
		sendButton.backgroundColor = UIColor.getCommunity(.darkBlue)
		sendButton.roundCorners(to: sendButton.frame.height / 2)
	}
	
	// MARK: - IBActions
	@IBAction func closeButtonTapped(_ sender: Any) {
		performSegue(withIdentifier: "unwindToMainAlert", sender: self)
	}
	
	@IBAction func addImageButtonTapped(_ sender: Any) {
	}
	
	@IBAction func sendButtonTapped(_ sender: Any) {
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
