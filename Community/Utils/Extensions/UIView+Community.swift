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
		layer.cornerRadius = radius
		layer.masksToBounds = true
	}
	
	func dropShadow() {
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize(width: 0, height: 10)
		layer.shadowRadius = 5
		layer.shadowOpacity = 0.3
	}
}
