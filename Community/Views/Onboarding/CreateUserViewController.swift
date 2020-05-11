//
//  CreateUserViewController.swift
//  Community
//
//  Created by Juan Pablo Ramos on 21/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {
	
	static func make() -> CreateUserViewController {
		return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(identifier: identifier) as! CreateUserViewController
	}
	
	static let identifier = "CreateUserVC"
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var lastnameTextField: UITextField!
	@IBOutlet weak var addressTextField: UITextField!
	@IBOutlet weak var phoneTextField: UITextField!
	@IBOutlet weak var emergencyPhoneTextField: UITextField!
	@IBOutlet weak var communityTextField: UITextField!
	@IBOutlet weak var continueButton: UIButton!
	
	var viewModel: CreateUserViewModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tap)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
		configureUI()
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
		viewModel = nil
	}
	
	@objc func dismissKeyboard() {
		self.view.endEditing(true)
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
	
	func configureUI() {
		continueButton.setTitle("Continue", for: .normal)
		continueButton.roundCorners(to: continueButton.frame.height / 2)
		continueButton.backgroundColor = UIColor.getCommunity(.darkBlue)
		continueButton.setTitleColor(.white, for: .normal)
	}
	
	@IBAction func continueButtonTapped(_ sender: Any) {
		let user = User()
		user.name = nameTextField.text!
		user.lastname = lastnameTextField.text!
		user.address = addressTextField.text!
		user.phone = phoneTextField.text!
		
		viewModel?.create(user: user, completion: { user in
			let tabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
			UIApplication.shared.windows.first?.rootViewController = tabBar
			UIApplication.shared.windows.first?.makeKeyAndVisible()
		})
	}
	
}

extension UIViewController {
	func showCreateUserVC(user: User) {
		let vc = CreateUserViewController.make()
		let vm = CreateUserViewModel()
		vc.viewModel = vm
		vc.modalPresentationStyle = .fullScreen
		present(vc, animated: true, completion: nil)
	}
}
