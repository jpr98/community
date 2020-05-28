//
//  AlertDetailViewController.swift
//  Community
//
//  Created by Juan Pablo Ramos on 10/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class AlertDetailViewController: UIViewController {
	
	static func make() -> AlertDetailViewController {
		return UIStoryboard(name: "Alerts", bundle: nil).instantiateViewController(identifier: identifier) as! AlertDetailViewController
	}
	
	static let identifier = "AlertDetail"
	
	@IBOutlet weak var closeButton: UIButton!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var descriptionTextView: UITextView!
	@IBOutlet weak var addImageButton: UIButton!
	@IBOutlet weak var sendButton: UIButton!
	
	let transition = CircularTransition()
	var viewModel: AlertDetailViewModel?
	
	override func viewDidLoad() {
		configureUI()
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tap)
		
//		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
		viewModel = nil
	}
	
	func configureUI() {
		guard let viewModel = viewModel else { return }
		
		view.backgroundColor = viewModel.viewColor
		closeButton.roundCorners(to: closeButton.frame.height / 2)
		
		addImageButton.backgroundColor = UIColor.getCommunity(.darkBlue)
		addImageButton.roundCorners(to: addImageButton.frame.height / 2)
		
		sendButton.backgroundColor = UIColor.getCommunity(.darkBlue)
		sendButton.roundCorners(to: sendButton.frame.height / 2)
		viewModel.sendButtonText.addObserver { [weak self] (_, value) in
			self?.sendButton.setTitle(value, for: .normal)
		}
		
		descriptionTextView.roundCorners(to: 10)
	}
	
	// MARK: - IBActions
	@IBAction func closeButtonTapped(_ sender: Any) {
		performSegue(withIdentifier: "unwindToMainAlert", sender: self)
	}
	
	@IBAction func addImageButtonTapped(_ sender: Any) {
		let vc = UIImagePickerController()
		vc.sourceType = .camera
		vc.allowsEditing = true
		vc.delegate = self
		present(vc, animated: true)
	}
	
	@IBAction func sendButtonTapped(_ sender: Any) {
		guard let description = descriptionTextView.text else { return }
		
		viewModel?.createReport(with: description) { [unowned self] success in
			if success {
				self.performSegue(withIdentifier: "unwindToMainAlert", sender: self)
			}
		}
	}
	
}

// MARK: - ImagePicker
extension AlertDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		guard let _ = info[.editedImage] as? UIImage else {
			print("no image found")
			return
		}
		
		addImageButton.isEnabled = false
	}
}

extension UIViewController {
	func showAlertDetailVC(alertType: AlertType, transitionDelegate delegate: UIViewControllerTransitioningDelegate) {
		let vc = AlertDetailViewController.make()
		let vm = AlertDetailViewModel(type: alertType)
		vc.viewModel = vm
		vc.transitioningDelegate = delegate
		vc.modalPresentationStyle = .custom
		present(vc, animated: true, completion: nil)
	}
}
