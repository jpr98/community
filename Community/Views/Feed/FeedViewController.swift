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
	
	var viewModel = FeedViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		registerCells()
		
		tableView.delegate = self
		tableView.dataSource = self
		
		viewModel.getReports() { success in
			DispatchQueue.main.async {
				if success {
					self.tableView.reloadData()
				} else {
					
				}
			}
		}
		
		viewModel.reports.addObserver { (_, _) in
			self.tableView.reloadData()
		}
	}
	
	func registerCells() {
		tableView.register(UINib(nibName: String(describing: FeedTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FeedTableViewCell.self))
	}

}

// MARK: - DataSource and Delegate
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.reports.value?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedTableViewCell.self)) as? FeedTableViewCell else {
			return UITableViewCell()
		}
		
		guard let reports = viewModel.reports.value else { return UITableViewCell() }
		
		cell.setup(indexPath: indexPath,
				   r: reports[indexPath.row],
				   delegate: self)
		
		return cell
	}
	
}

// MARK: - FeedTableViewCellDelegate
extension FeedViewController: FeedTableViewCellDelegate {
	
	func didPressInfo(at indexPath: IndexPath) {
		guard let reports = viewModel.reports.value else { return }
		showFeedDetail(for: reports[indexPath.row])
	}
	
}
