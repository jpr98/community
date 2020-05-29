//
//  UIViewController+Community.swift
//  Community
//
//  Created by Juan Pablo Ramos on 11/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

extension UIViewController {
	
	func alert(message: String, _ handler: (()->())? = nil) {
		let alertVC = UIAlertController(title: "Ups!", message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
		alertVC.addAction(okAction)
		present(alertVC, animated: true, completion: handler)
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	
	@objc func keyboardWillShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
			if self.view.frame.origin.y == 0 {
				self.view.frame.origin.y -= keyboardSize.height
			}
		}
	}

	@objc func keyboardWillHide(notification: NSNotification) {
		if self.view.frame.origin.y != 0 {
			self.view.frame.origin.y = 0
		}
	}
}
