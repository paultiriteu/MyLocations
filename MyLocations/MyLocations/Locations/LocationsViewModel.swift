//
//  LocationsViewModel.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 15/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import RealmSwift

protocol LocationsViewModelDelegate: class {
    func locationsViewModel(_ viewModel: LocationsViewModel, didUpdateLocations locations: [LocationModel])
}

class LocationsViewModel {
    private let realm = try! Realm()
    private let repository: LocationsRepository
    private let router: MainRouter
    var locations = [LocationModel]() {
        didSet {
            delegate?.locationsViewModel(self, didUpdateLocations: locations)
        }
    }
    
    weak var delegate: LocationsViewModelDelegate?
    
    init(repository: LocationsRepository, router: MainRouter) {
        self.repository = repository
        self.router = router
        
        repository.observeRealmLocations { [weak self] (locations) in
            print(locations.count)
            self?.locations = locations
        }
    }
    
    func loadLocations() {
        repository.loadLocations(onError: {
            print("could not load locations")
        })
    }
    
    @objc func deleteLocation(index: Int, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        repository.deleteLocation(location: locations[index], onSuccess: onSuccess, onError: onError)
    }
    
    func toDetailsViewController(index: Int) {
        router.toLocationDetailsViewController(location: locations[index])
    }
}
