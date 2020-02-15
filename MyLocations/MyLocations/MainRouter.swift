//
//  MainRouter.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 14/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import UIKit

class MainRouter {
    private var navController: UINavigationController?
    
    func getLocationsViewController() -> UINavigationController {
        let repository = LocationsRepository()
        let viewModel = LocationsViewModel(repository: repository)
        let viewController = LocationsTableViewController(viewModel: viewModel)
        
        navController = UINavigationController(rootViewController: viewController)
        navController?.setNavigationBarHidden(true, animated: true)
        
        return navController!
    }
}
