//
//  LocationsViewController.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 14/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController {
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
    }
}
