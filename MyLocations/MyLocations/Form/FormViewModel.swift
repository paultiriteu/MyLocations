//
//  FormViewModel.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 22/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import UIKit

enum FormPurpose {
    case addLocation
    case editLocation
}

enum FormField: String {
    case tag = "Tag"
    case address = "Address"
    case imageURL = "Image URL"
    case latitude = "Latitude"
    case longitude = "Longitude"
}

class FormViewModel {
    private let repository: FormRepository
    private let router: MainRouter
    
    let formPurpose: FormPurpose
    let location: LocationModel?
    
    var locationFields: [FormField] = [.tag, .address, .imageURL, .latitude, .longitude]
    var formCells = [FormFieldTableViewCell]()
    
    init(formPurpose: FormPurpose, location: LocationModel?, repository: FormRepository, router: MainRouter) {
        self.formPurpose = formPurpose
        self.location = location
        self.repository = repository
        self.router = router
    }
    
    func sendForm() {
        let newLocation = LocationModel()
        newLocation.tag = location?.tag ?? ""
        
        formCells.forEach { cell in
            switch cell.fieldName {
            case .tag:
                newLocation.tag = cell.getValue()
            case .address:
                newLocation.address = cell.getValue()
            case .imageURL:
                newLocation.imageUrl = cell.getValue()
            case .latitude:
                newLocation.latitude = Float(cell.getValue()) ?? location?.latitude ?? 0
            case .longitude:
                newLocation.longitude = Float(cell.getValue()) ?? location?.longitude ?? 0
            }
        }
        repository.processLocation(location: newLocation, onSuccess: { [weak self] in
            guard let self = self else { return }
            self.router.popToRootViewController()
        }, onError: {
            
        })
    }
}
