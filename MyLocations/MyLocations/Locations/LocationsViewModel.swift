//
//  LocationsViewModel.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 15/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import Foundation

class LocationsViewModel {
    private let repository: LocationsRepository
    
    init(repository: LocationsRepository) {
        self.repository = repository
    }
}
