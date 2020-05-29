//
//  EmergencyContactViewController.swift
//  Community
//
//  Created by Juan Pablo Ramos on 28/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class EmergencyContactViewController: UIViewController {

	static func make() -> EmergencyContactViewController {
		return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(identifier: identifier) as! EmergencyContactViewController
	}
	
	static let identifier = "EmergencyVC"
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	@IBOutlet weak var contactTextField: UITextField!
	@IBOutlet weak var continueButton: UIButton!
	@IBOutlet weak var skipButton: UIButton!
	
	var viewModel: EmergencyContactViewModel?
	
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
		guard let viewModel = viewModel else { return }
		viewModel.title.addObserver { [unowned self] (_, value) in
			self.titleLabel.text = value
		}
		viewModel.subtitle.addObserver { [unowned self] (_, value) in
			self.subtitleLabel.text = value
		}
		
		continueButton.setTitleColor(.getCommunity(.darkBlue), for: .normal)
		continueButton.setTitle("Continuar", for: .normal)
		continueButton.setTitleColor(.white, for: .normal)
		continueButton.roundCorners(to: continueButton.frame.height / 2)
		continueButton.backgroundColor = UIColor.getCommunity(.lightBlue)
		
		skipButton.setTitleColor(UIColor.getCommunity(.darkBlue), for: .normal)
		skipButton.setTitle("Saltar", for: .normal)
	}
    
	// MARK: - IBActions
	@IBAction func continueButtonTapped(_ sender: Any) {
		guard let email = contactTextField.text else {
			alert(message: "Por favor ingrese un correo para continuar. Si desea puede realizar este paso más tarde.")
			return
		}
		
		viewModel?.addEmergencyContact(email: email) { success in
			DispatchQueue.main.async {
				if success {
					self.moveToTabBar()
				} else {
					self.alert(message: "Hubo un error dando de alta su contacto de emergencia. Por favor trate más tarde.")
				}
			}
		}
	}
	
	@IBAction func skipButtonTapped(_ sender: Any) {
		moveToTabBar()
	}
	
	private func moveToTabBar() {
		let tabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
		UIApplication.shared.windows.first?.rootViewController = tabBar
		UIApplication.shared.windows.first?.makeKeyAndVisible()
	}
}

extension UIViewController {
	func showEmergencyVC() {
		let vc = EmergencyContactViewController.make()
		let vm = EmergencyContactViewModel(user: User.shared)
		vc.viewModel = vm
		vc.modalPresentationStyle = .fullScreen
		present(vc, animated: true, completion: nil)
	}
}
