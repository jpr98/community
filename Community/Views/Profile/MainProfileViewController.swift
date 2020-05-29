//
//  MainProfileViewController.swift
//  Community
//
//  Created by Juan Pablo Ramos on 22/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class MainProfileViewController: UIViewController {

	@IBOutlet weak var profilePictrueImageView: UIImageView!
	@IBOutlet weak var profilePictureButton: UIButton!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var editProfileButton: UIButton!
	@IBOutlet weak var emergencyButton: UIButton!
	@IBOutlet weak var creditsButton: UIButton!
	@IBOutlet weak var logoutButton: UIButton!
	
	var viewModel = ProfileViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}

	func configureUI() {
		nameLabel.text = User.shared.name
		
		profilePictrueImageView.roundCorners(to: profilePictrueImageView.frame.height / 2)
		if User.shared.imageURL.isEmpty {
			profilePictrueImageView.image = UIImage(named: "pp")
		} else {
			profilePictrueImageView.downloaded(from: User.shared.imageURL)
		}
		
		editProfileButton.setTitleColor(.getCommunity(.darkBlue), for: .normal)
		editProfileButton.setTitle("Editar perfil", for: .normal)
		editProfileButton.setTitleColor(.white, for: .normal)
		editProfileButton.roundCorners(to: editProfileButton.frame.height / 2)
		editProfileButton.backgroundColor = UIColor.getCommunity(.lightBlue)
		
		emergencyButton.setTitleColor(.getCommunity(.darkBlue), for: .normal)
		emergencyButton.setTitle("Contacto de emergencia", for: .normal)
		emergencyButton.setTitleColor(.white, for: .normal)
		emergencyButton.roundCorners(to: emergencyButton.frame.height / 2)
		emergencyButton.backgroundColor = UIColor.getCommunity(.lightBlue)
		
		creditsButton.setTitleColor(.getCommunity(.darkBlue), for: .normal)
		creditsButton.setTitle("Creditos", for: .normal)
		creditsButton.setTitleColor(.white, for: .normal)
		creditsButton.roundCorners(to: creditsButton.frame.height / 2)
		creditsButton.backgroundColor = UIColor.getCommunity(.lightBlue)
		
		logoutButton.setTitleColor(.getCommunity(.darkBlue), for: .normal)
		logoutButton.setTitle("Cerrar sesión", for: .normal)
		logoutButton.setTitleColor(.white, for: .normal)
		logoutButton.roundCorners(to: logoutButton.frame.height / 2)
		logoutButton.backgroundColor = UIColor.getCommunity(.lightBlue)
		
	}
	
	// MARK: - IBActions
	@IBAction func profilePictureButtonTapped(_ sender: Any) {
	}
	
	@IBAction func editProfileButtonTapped(_ sender: Any) {
		showCreateUserVC(user: User.shared, isOB: false)
	}
	
	@IBAction func emergencyButtonTapped(_ sender: Any) {
		showEmergencyVC(isOb: false)
	}
	
	@IBAction func creditsButtonTapped(_ sender: Any) {
		showCredits()
	}
	
	
	@IBAction func logoutButtonTapped(_ sender: Any) {
		UserDefaults.standard.removeObject(forKey: "user_loggedin")
		let ob = WelcomeViewController.make()
		UIApplication.shared.windows.first?.rootViewController = ob
		UIApplication.shared.windows.first?.makeKeyAndVisible()
	}
	
}
