//
//  LocationDetailsViewModel.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 16/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import Foundation

class LocationDetailsViewModel {
    private let repository: LocationDetailsRepository
    let location: LocationModel
    
    init(location: LocationModel, repository: LocationDetailsRepository) {
        self.location = location
        self.repository = repository
    }
}
