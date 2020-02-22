//
//  FormRepository.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 22/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import RealmSwift

class FormRepository {
    var realm: Realm = try! Realm()
    
    func processLocation(location: LocationModel, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        do {
            try realm.write {
                if let existingLocation = realm.objects(LocationModel.self).filter("tag = %@", location.tag).first {
                    existingLocation.address = location.address
                    existingLocation.imageUrl = location.imageUrl
                    existingLocation.latitude = location.latitude
                    existingLocation.longitude = location.longitude
                } else {
                    realm.add(location)
                }
                onSuccess()
            }
        } catch {
            onError()
        }
    }
}
