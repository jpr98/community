//
//  LoginViewController.swift
//  Community
//
//  Created by Juan Pablo Ramos on 21/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	
	static func make() -> LoginViewController {
		return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(identifier: identifier) as! LoginViewController
	}
	
	static let identifier = "LoginVC"
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var continueButton: UIButton!
	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var changeUsecaseButton: UIButton!
	
	var viewModel: LoginViewModel?
	
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
		viewModel.subtitle.addObserver() { [unowned self] (_, value) in
			self.subtitleLabel.text = value
		}
		viewModel.changeButtonTitle.addObserver() { [unowned self] (_, value) in
			self.changeUsecaseButton.setTitle(value, for: .normal)
		}
		
		changeUsecaseButton.setTitleColor(.getCommunity(.darkBlue), for: .normal)
		continueButton.setTitle("Continuar", for: .normal)
		continueButton.roundCorners(to: continueButton.frame.height / 2)
		continueButton.backgroundColor = UIColor.getCommunity(.lightBlue)
		changeButtonState(enabled: false)
		imageView.image = UIImage(named: "community_logo")
		backButton.tintColor = UIColor.getCommunity(.darkBlue)
	}
	
	func changeButtonState(enabled: Bool) {
		continueButton.isEnabled = enabled
		if enabled {
			continueButton.backgroundColor = UIColor.getCommunity(.lightBlue)
			continueButton.setTitleColor(.white, for: .normal)
		} else {
			continueButton.backgroundColor = .lightGray
			continueButton.setTitleColor(.gray, for: .normal)
		}
	}
	
	// MARK: - IB ACTIONS
	@IBAction func continueButtonTapped(_ sender: Any) {
		guard let email = emailTextField.text, let password = passwordTextField.text else {
			alert(message: "Parece que falta información.")
			return
		}
		
		if viewModel?.usecase == .login {
			viewModel?.authenticate(with: email, and: password) { [unowned self] success in
				DispatchQueue.main.async {
					if success {
						let tabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
						UIApplication.shared.windows.first?.rootViewController = tabBar
						UIApplication.shared.windows.first?.makeKeyAndVisible()
					} else {
						self.alert(message: "Error iniciando sesión. Por favor intente de nuevo.") {
							self.passwordTextField.text = ""
							self.changeButtonState(enabled: false)
						}
					}
				}
			}
		} else {
			let user = User(email: email, password: password)
			self.showCreateUserVC(user: user)
		}
		
	}
	
	@IBAction func backButtonTapped(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func changeUsecaseButtonTapped(_ sender: Any) {
		viewModel?.changeUsecase()
	}
	
	
	@IBAction func didEndEditingEmail(_ sender: Any) {
		if let pass = passwordTextField.text, !pass.isEmpty, let email = emailTextField.text, !email.isEmpty {
			changeButtonState(enabled: true)
		} else {
			changeButtonState(enabled: false)
		}
	}
	
	@IBAction func didEndEditingPassword(_ sender: Any) {
		if let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty {
			changeButtonState(enabled: true)
		} else {
			changeButtonState(enabled: false)
		}
	}
	
}

extension UIViewController {
	func showLoginVC(for usecase: LoginUseCase) {
		let vc = LoginViewController.make()
		let vm = LoginViewModel(usecase: usecase)
		vc.viewModel = vm
		vc.modalPresentationStyle = .fullScreen
		present(vc, animated: true, completion: nil)
	}
}
