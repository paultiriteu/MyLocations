//
//  LocationsViewModel.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 15/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import Foundation

protocol LocationsViewModelDelegate: class {
    func locationsViewModel(_ viewModel: LocationsViewModel, didUpdateLocations locations: [LocationModel])
}

class LocationsViewModel {
    private let repository: LocationsRepository
    private let router: MainRouter
    var locations = [LocationModel]()
    
    weak var delegate: LocationsViewModelDelegate?
    
    init(repository: LocationsRepository, router: MainRouter) {
        self.repository = repository
        self.router = router
    }
    
    func getLocations() {
        repository.getLocations(onSuccess: { [weak self] locations in
            guard let weakSelf = self else { return }
            weakSelf.locations = locations
            weakSelf.delegate?.locationsViewModel(weakSelf, didUpdateLocations: locations)
        }, onError: { [weak self] in
            print("error")
        })
    }
    
    func toDetailsViewController(index: Int) {
        router.toLocationDetailsViewController(location: locations[index])
    }
}
