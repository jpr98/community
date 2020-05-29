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
	
	func configureUI() {
		continueButton.setTitle("Continuar", for: .normal)
		continueButton.roundCorners(to: continueButton.frame.height / 2)
		continueButton.backgroundColor = UIColor.getCommunity(.darkBlue)
		continueButton.setTitleColor(.white, for: .normal)
	}
	
	@IBAction func continueButtonTapped(_ sender: Any) {
		let userRequest = CreateUserRequest(name: nameTextField.text!,
											email: "",
											password: "",
											colony: Community().id,
											address: addressTextField.text!,
											phone: phoneTextField.text!,
											student: false)
		
		viewModel?.create(request: userRequest) { success in
			DispatchQueue.main.async {
				if success {
					self.showEmergencyVC()
				} else {
					self.alert(message: "Hubo un problema creando su usuario. Por favor intente de nuevo más tarde.")
				}
			}
		}
	}
	
}

extension UIViewController {
	func showCreateUserVC(user: User) {
		let vc = CreateUserViewController.make()
		let vm = CreateUserViewModel(for: user)
		vc.viewModel = vm
		vc.modalPresentationStyle = .fullScreen
		present(vc, animated: true, completion: nil)
	}
}
