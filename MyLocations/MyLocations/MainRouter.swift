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
        let viewModel = LocationsViewModel(repository: repository, router: self)
        let viewController = LocationsTableViewController(viewModel: viewModel)
        
        navController = UINavigationController(rootViewController: viewController)
        navController?.setNavigationBarHidden(true, animated: true)
        
        return navController!
    }
    
    func toLocationDetailsViewController(location: LocationModel) {
        let repository = LocationDetailsRepository()
        let viewModel = LocationDetailsViewModel(location: location, repository: repository, router: self)
        let viewController = LocationDetailsViewController(viewModel: viewModel)
        
        navController?.pushViewController(viewController, animated: true)
    }
    
    func toFormViewController(formPurpose: FormPurpose, location: LocationModel?) {
        let repository = FormRepository()
        let viewModel = FormViewModel(formPurpose: formPurpose, location: location, repository: repository, router: self)
        let viewController = FormViewController(viewModel: viewModel)
        
        navController?.pushViewController(viewController, animated: true)
    }
    
    func popToRootViewController() {
        navController?.popToRootViewController(animated: true)
    }
}
