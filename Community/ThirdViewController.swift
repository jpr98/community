//
//  FeedViewController.swift
//  Community
//
//  Created by Juan Pablo Ramos on 22/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func logout(_ sender: Any) {
		UserDefaults.standard.removeObject(forKey: "user_loggedin")
		let ob = WelcomeViewController.make()
		UIApplication.shared.windows.first?.rootViewController = ob
		UIApplication.shared.windows.first?.makeKeyAndVisible()
	}
	
}
