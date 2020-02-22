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

class FormViewModel {
    private let repository: FormRepository
    private let router: MainRouter
    
    let formPurpose: FormPurpose
    let location: LocationModel?
    
    var locationFields = ["Tag", "Address", "Image URL", "Latitude", "Longitude"]
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
            if cell.fieldName == "Tag" {
                newLocation.tag = cell.getValue()
            }
            if cell.fieldName == "Address" {
                newLocation.address = cell.getValue()
            }
            if cell.fieldName == "Image URL" {
                newLocation.imageUrl = cell.getValue()
            }
            if cell.fieldName == "Latitude" {
                newLocation.latitude = Float(cell.getValue()) ?? location?.latitude ?? 0
            }
            if cell.fieldName == "Longitude" {
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
