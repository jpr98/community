//
//  FeedDetailViewController.swift
//  Community
//
//  Created by Juan Pablo Ramos on 29/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {

	static func make() -> FeedDetailViewController {
		return UIStoryboard(name: "Feed", bundle: nil).instantiateViewController(identifier: identifier) as! FeedDetailViewController
	}
	
	static let identifier = "FeedDetail"
	
	@IBOutlet weak var optionsButton: UIButton!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var nameTitle: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var helpButton: UIButton!
	
	var viewModel: FeedDetailViewModel?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureUI()
	}
	
	deinit {
		viewModel = nil
	}
	
	func configureUI() {
		guard let viewModel = viewModel else { return }
		
		titleLabel.text = viewModel.title
		nameTitle.text = viewModel.name
		addressLabel.text = viewModel.address
		descriptionLabel.text = viewModel.description
		
		helpButton.setTitle("Enviar ayuda", for: .normal)
		helpButton.backgroundColor = UIColor.getCommunity(.darkBlue)
		helpButton.roundCorners(to: helpButton.frame.height / 2)
		helpButton.setTitleColor(.white, for: .normal)
		
	}
	
	// MARK: - IBActions
	@IBAction func helpButton(_ sender: Any) {
	}
	
	@IBAction func optionsButtonTapped(_ sender: Any) {
		let actionSheet = UIAlertController(title: "Opciones", message: "Seleccione una opción", preferredStyle: .actionSheet)
		let deleteAction = UIAlertAction(title: "Eliminar", style: .destructive) { _ in
			// delete report
		}
		if User.shared.id == "" {
			
		}
		
	}

}

extension UIViewController {
	func showFeedDetail(for report: Report) {
		let vc = FeedDetailViewController.make()
		let vm = FeedDetailViewModel(report: report)
		vc.viewModel = vm
		present(vc, animated: true, completion: nil)
	}
}
