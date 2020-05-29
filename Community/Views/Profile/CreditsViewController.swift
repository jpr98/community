//
//  CreditsViewController.swift
//  Community
//
//  Created by Juan Pablo Ramos on 29/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
	
	static func make() -> CreditsViewController {
		return UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: identifier) as! CreditsViewController
	}
	
	static let identifier = "Credits"
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var creditsLabel: UILabel!
	@IBOutlet weak var backButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		titleLabel.text = "Creditos"
		creditsLabel.text = """
		Community fue desarrollado por Juan Pablo Ramos, Adrian Hinojosa y Daniela Guajardo como proyecto final para la materia Proyecto de Desarrollo para dispositivos móviles en el semestre Febrero-Junio 2020.

		Las imágenes y la paleta de colores fue proporcionada por el profesor Alejandro Martínez Bacca y su equipo de trabajo.
		"""
		
		backButton.setTitle("Regresar", for: .normal)
		backButton.setTitleColor(.white, for: .normal)
		backButton.backgroundColor = UIColor.getCommunity(.orange)
		backButton.roundCorners(to: backButton.frame.height / 2)
		
	}
	
	@IBAction func backButtonTapped(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
}

extension UIViewController {
	func showCredits() {
		let vc = CreditsViewController.make()
		vc.modalPresentationStyle = .fullScreen
		present(vc, animated: true, completion: nil)
	}
}
