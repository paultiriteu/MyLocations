//
//  LocationsViewController.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 14/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import UIKit
import CoreLocation

class LocationsTableViewController: UITableViewController {
    private let viewModel: LocationsViewModel
    private let locationManager = CLLocationManager()
    private var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    init(viewModel: LocationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LocationsTableViewController", bundle: Bundle(for: LocationsTableViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        showSpinner(onView: view)
        viewModel.loadLocations()
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configureUI() {
        let rightBarButton = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(toAddViewController))
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        viewModel.delegate = self
    
        tableView.register(UINib(nibName: "LocationTableViewCell", bundle: Bundle(for: LocationTableViewCell.self)), forCellReuseIdentifier: "LocationTableViewCell")
        tableView.isScrollEnabled = true
    }
    
    @objc func toAddViewController() {
        viewModel.toAddViewController()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as? LocationTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(location: viewModel.locations[indexPath.row], userLocation: userLocation)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.toDetailsViewController(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextualAction = UIContextualAction(style: .destructive, title: "Delete", handler: { [weak self] _,_,_  in
            guard let self = self else { return }
            self.viewModel.deleteLocation(index: indexPath.row, onSuccess: {
                tableView.reloadData()
            }, onError: {
                let alert = UIAlertController(title: "Error", message: "Could not delete the location", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.navigationController?.present(alert, animated: true, completion: nil)
            })
        })
        return UISwipeActionsConfiguration(actions: [contextualAction])
    }
}

extension LocationsTableViewController: LocationsViewModelDelegate {
    func locationsViewModel(_ viewModel: LocationsViewModel, didUpdateLocations locations: [LocationModel]) {
        tableView.reloadData()
        removeSpinner()
    }
}

extension LocationsTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("Latitude \(locValue.latitude), longitude \(locValue.longitude)")
        userLocation = locValue
        tableView.reloadData()
    }
}
