//
//  MainAlertViewController.swift
//  Community
//
//  Created by Juan Pablo Ramos on 21/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class MainAlertViewController: UIViewController {

	@IBOutlet weak var firstButton: UIButton!
	@IBOutlet weak var secondButton: UIButton!
	@IBOutlet weak var thirdButton: UIButton!
	
	private let transition = CircularTransition()
	private var doneAnimation = false
	private var titleColor: UIColor?
	var viewModel = MainAlertsViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureUI()
		setGestures(withDuration: 0.2)
	}
	
	func setGestures(withDuration duration: TimeInterval) {
		let longFirst = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
		longFirst.minimumPressDuration = duration
		firstButton.addGestureRecognizer(longFirst)
		
		let longSecond = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
		longSecond.minimumPressDuration = duration
		secondButton.addGestureRecognizer(longSecond)
		
		let longThird = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
		longThird.minimumPressDuration = duration
		thirdButton.addGestureRecognizer(longThird)
	}
	
	func configureUI() {
		firstButton.backgroundColor = UIColor.getCommunity(.orange)
		firstButton.roundCorners(to: firstButton.frame.height / 2)
		viewModel.crimeButtonText.addObserver { [unowned self] (_, value) in
			self.firstButton.setTitle(value, for: .normal)
		}
		
		secondButton.backgroundColor = UIColor.getCommunity(.yellow)
		secondButton.roundCorners(to: secondButton.frame.height / 2)
		viewModel.suspectButtonText.addObserver { [unowned self] (_, value) in
			self.secondButton.setTitle(value, for: .normal)
		}
		
		thirdButton.backgroundColor = UIColor.getCommunity(.lightBlue)
		thirdButton.roundCorners(to: thirdButton.frame.height / 2)
		viewModel.medicButtonText.addObserver { [unowned self] (_, value) in
			self.thirdButton.setTitle(value, for: .normal)
		}
	}
	
	@objc func longTap(gesture: UILongPressGestureRecognizer) {
		guard let button = gesture.view as? UIButton else { return }
		
		var type: AlertType
		switch button {
		case firstButton:
			type = .suspect
		case secondButton:
			type = .crime
		case thirdButton:
			type = .medic
		default:
			return
		}
		
		if gesture.state == .began {
			growButton(button) {
				self.prepareTransitionFor(button)
				self.enableButtonsInteractions()
				self.showAlertDetailVC(alertType: type, transitionDelegate: self)
			}
		} else if gesture.state == .ended {
			smallerButton(button)
		}
	}
	
	@IBAction func unwindToMainAlertVC(_ segue: UIStoryboardSegue) {}
	
	@IBAction func firstButtonTapped(_ sender: Any) {
		viewModel.createReport(of: .crime)
	}
	
	@IBAction func secondButtonTapped(_ sender: Any) {
		viewModel.createReport(of: .suspect)
	}
	
	@IBAction func thirdButtonTapped(_ sender: Any) {
		viewModel.createReport(of: .medic)
	}
	
}

// MARK: - Transitions
extension MainAlertViewController: UIViewControllerTransitioningDelegate {
	
	func prepareTransitionFor(_ button: UIButton) {
		transition.duration = 0.25
		transition.startingPoint = view.convert(button.center, from: button.superview)
		transition.circleColor = button.backgroundColor!
	}
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		transition.transitionMode = .present
		return transition
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		transition.transitionMode = .dismiss
		return transition
	}
	
}

// MARK: - Animations
extension MainAlertViewController {
	
	private func growButton(_ button: UIButton, _ completion: (()->())? = nil) {
		button.superview!.bringSubviewToFront(button)
		titleColor = button.titleColor(for: .normal)
		button.setTitleColor(.clear, for: .normal)
		disableButtonsExcept(button)
		
		UIView.animate(withDuration: 1, delay: 0, options: [.allowUserInteraction], animations: {
			button.transform = CGAffineTransform.init(scaleX: 10, y: 10)
			self.doneAnimation = true
		}) { (_) in
			if self.doneAnimation {
				completion?()
			} else {
				self.enableButtonsInteractions()
			}
		}
	}
	
	private func smallerButton(_ button: UIButton) {
		button.setTitleColor(titleColor, for: .normal)
		UIView.animate(withDuration: 0.4, delay: 0, options: [.allowUserInteraction], animations: {
			self.doneAnimation = false
			button.transform = CGAffineTransform.identity
		})
	}
	
	private func disableButtonsExcept(_ button: UIButton) {
		if button != firstButton {
			firstButton.isUserInteractionEnabled = false
		}
		if button != secondButton {
			secondButton.isUserInteractionEnabled = false
		}
		if button != thirdButton {
			thirdButton.isPointerInteractionEnabled = false
		}
	}
	
	private func enableButtonsInteractions() {
		doneAnimation = false
		firstButton.isUserInteractionEnabled = true
		secondButton.isUserInteractionEnabled = true
		thirdButton.isUserInteractionEnabled = true
	}
	
}
