//
//  WelcomeViewController.swift
//  Community
//
//  Created by Juan Pablo Ramos on 21/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
	
	static func make() -> WelcomeViewController {
		return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(identifier: identifier) as! WelcomeViewController
	}
	
	static let identifier = "WelcomeVC"
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var loginButton: UIButton!
	@IBOutlet weak var signupButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}
	
	func configureUI() {
		imageView.image = UIImage(named: "community_logo")
		imageView.contentMode = .scaleAspectFit
		
		loginButton.setTitle("Iniciar sesión", for: .normal)
		loginButton.roundCorners(to: loginButton.frame.height / 2)
		loginButton.backgroundColor = UIColor.getCommunity(.lightBlue)
		loginButton.setTitleColor(.white, for: .normal)
		
		signupButton.setTitle("Registrarse", for: .normal)
		signupButton.roundCorners(to: signupButton.frame.height / 2)
		signupButton.backgroundColor = UIColor.getCommunity(.orange)
		signupButton.setTitleColor(.white, for: .normal)
	}
	
	@IBAction func loginButtonTapped(_ sender: Any) {
		showLoginVC(for: .login)
	}
	
	@IBAction func signupButtonTapped(_ sender: Any) {
		showLoginVC(for: .signup)
	}
	
}

extension UIViewController {
	func showWelcomeVC() {
		let vc = WelcomeViewController.make()
		present(vc, animated: true, completion: nil)
	}
}
