//
//  Community+UIColor.swift
//  Community
//
//  Created by Juan Pablo Ramos on 22/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

enum CommunityColors {
	case orange
	case lightBlue
	case darkBlue
	case yellow
}
extension UIColor {
	static func getCommunity(_ color: CommunityColors, with alpha: CGFloat = 1) -> UIColor {
		switch color {
		case .orange:
			return UIColor(red: 243/255, green: 172/255, blue: 123/255, alpha: alpha)
		case .lightBlue:
			return UIColor(red: 112/255, green: 128/255, blue: 188/255, alpha: alpha)
		case .darkBlue:
			return UIColor(red: 50/255, green: 53/255, blue: 144/255, alpha: alpha)
		case .yellow:
			return UIColor(red: 251/255, green: 228/255, blue: 156/255, alpha: alpha)
		}
	}
}
