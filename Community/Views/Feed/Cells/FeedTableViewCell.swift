//
//  FeedTableViewCell.swift
//  Community
//
//  Created by Juan Pablo Ramos on 28/05/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

protocol FeedTableViewCellDelegate: class {
	func didPressInfo(at indexPath: IndexPath)
}

class FeedTableViewCell: UITableViewCell {

	@IBOutlet weak var shadowView: UIView!
	@IBOutlet weak var cardView: UIView!
	@IBOutlet weak var colorView: UIView!
	@IBOutlet weak var labelsStackView: UIStackView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	@IBOutlet weak var infoButton: UIButton!
	
	private var currentIndexPath = IndexPath()
	private weak var report: Report?
	private weak var delegate: FeedTableViewCellDelegate?
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
		cardView.roundCorners(to: 8)
		cardView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
		cardView.layer.borderWidth = 0.5
		shadowView.dropShadow()
    }
	
	func setup(indexPath: IndexPath, r: Report, delegate: FeedTableViewCellDelegate) {
		currentIndexPath = indexPath
		report = r
		self.delegate = delegate
		
		guard let type = r.type,
			let name = r.user?.name,
			let address = r.user?.address else { return }
		
		titleLabel.text = type.getText()
		subtitleLabel.text = "Reportado por \(name)"
		if name.isEmpty && !address.isEmpty {
			subtitleLabel.text = "Reportado en \(address)"
		}
		
		
		colorView.backgroundColor = UIColor.getCommunity(type.getColor())
	}

    

	// MARK: - IBActions
	@IBAction func infoButtonTapped(_ sender: Any) {
		delegate?.didPressInfo(at: currentIndexPath)
	}
	
}
