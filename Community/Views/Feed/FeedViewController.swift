//
//  FeedViewController.swift
//  Community
//
//  Created by Juan Pablo Ramos on 21/04/20.
//  Copyright © 2020 ITESM. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	func registerCells() {
		tableView.register(UINib(nibName: String(describing: FeedTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FeedTableViewCell.self))
	}

}

// MARK: - DataSource and Delegate
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedTableViewCell.self)) as? FeedTableViewCell else {
			return UITableViewCell()
		}
		
//		cell.setup(indexPath: indexPath,
//				   vm: <#T##FeedTableViewCellViewModel#>,
//				   delegate: self)
		
		return cell
	}
	
}

// MARK: - FeedTableViewCellDelegate
extension FeedViewController: FeedTableViewCellDelegate {
	
	func didPressInfo(at indexPath: IndexPath) {
		// segue to details
	}
	
}
