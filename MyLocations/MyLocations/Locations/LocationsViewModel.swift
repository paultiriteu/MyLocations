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
    }
    
    func getLocations() {
        repository.getLocations(onSuccess: { [weak self] locations in
            guard let self = self else { return }
            self.repository.getRealmLocations { response in
                self.locations = response
            }
            self.delegate?.locationsViewModel(self, didUpdateLocations: locations)
        }, onError: { [weak self] in
            print("error")
        })
    }
    
    @objc func deleteLocation(index: Int, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        repository.deleteLocation(location: locations[index], onSuccess: {
            self.repository.getRealmLocations { response in
                self.locations = response
                onSuccess()
            }
        }, onError: {
            onError()
        })
    }
    
    func toDetailsViewController(index: Int) {
        router.toLocationDetailsViewController(location: locations[index])
    }
}
