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
    var locations = [LocationModel]()
    
    weak var delegate: LocationsViewModelDelegate?
    
    init(repository: LocationsRepository) {
        self.repository = repository
    }
    
    func getLocations() {
        repository.getLocations(onSuccess: { [weak self] locations in
            self?.locations = locations
        }, onError: { [weak self] in
            print("error")
        })
    }
}
