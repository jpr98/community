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
	private weak var viewModel: FeedTableViewCellViewModel?
	private weak var delegate: FeedTableViewCellDelegate?
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
		cardView.roundCorners(to: 8)
		shadowView.dropShadow()
    }
	
	func setup(indexPath: IndexPath, vm: FeedTableViewCellViewModel, delegate: FeedTableViewCellDelegate) {
		currentIndexPath = indexPath
		viewModel = vm
		self.delegate = delegate
		
		titleLabel.text = vm.title
		subtitleLabel.text = vm.subtitle
		
		colorView.backgroundColor = vm.color
	}

    

	// MARK: - IBActions
	@IBAction func infoButtonTapped(_ sender: Any) {
		delegate?.didPressInfo(at: currentIndexPath)
	}
	
}
