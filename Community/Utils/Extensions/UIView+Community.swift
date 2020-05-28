//
//  UIView+Community.swift
//  Community
//
//  Created by Juan Pablo Ramos on 21/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

extension UIView {
	
	func roundCorners(to radius: CGFloat) {
		self.layer.cornerRadius = radius
		self.layer.masksToBounds = true
	}
	
	func dropShadow() {
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOpacity = 1
		self.layer.shadowOffset = .zero
		self.layer.shadowRadius = 10
		self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
	}
}
