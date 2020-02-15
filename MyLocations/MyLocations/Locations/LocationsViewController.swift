//
//  LocationsViewController.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 14/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import UIKit

class LocationsViewController: UITableViewController {
    private let viewModel: LocationsViewModel
    
    init(viewModel: LocationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LocationsViewController", bundle: Bundle(for: LocationsViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
//        tableView.delegate = self
//        tableView.dataSource = self
        viewModel.delegate = self
        tableView.register(UINib(nibName: "LocationTableViewCell", bundle: Bundle(for: LocationTableViewCell.self)), forCellReuseIdentifier: "LocationTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LocationTableViewCell()
        cell.configure(location: viewModel.locations[indexPath.row])
        return cell
    }
}

extension LocationsViewController: LocationsViewModelDelegate {
    func locationsViewModel(_ viewModel: LocationsViewModel, didUpdateLocations locations: [LocationModel]) {
        tableView.reloadData()
    }
    
    
}
