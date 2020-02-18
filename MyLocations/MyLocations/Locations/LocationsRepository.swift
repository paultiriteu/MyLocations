//
//  LocationsRepository.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 15/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import RealmSwift
import Alamofire

class LocationsRepository {
    private var realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    func getLocations(onSuccess: @escaping ([LocationModel]) -> Void, onError: @escaping () -> Void) {
        guard let url = URL(string: "https://demo8553475.mockable.io/mylocations") else {
            onError()
            return
        }
        
        Alamofire.request(url).responseJSON { [weak self] response in
            guard let self = self else { return }
            guard let data = response.data else {
                onError()
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode([LocationModel].self, from: data)
                
                try self.realm.write {
                    result.forEach { location in
                        self.realm.add(location, update: .all)
                    }
                }
                
                onSuccess(result)
            } catch {
                onError()
            }
        }
    }
    
    func getRealmLocations(onSuccess: @escaping ([LocationModel]) -> Void) {
        let locations = Array(realm.objects(LocationModel.self))
        onSuccess(locations)
    }
    
    func deleteLocation(location: LocationModel, onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        do {
            if let existingLocation = realm.objects(LocationModel.self).filter("tag = %@", location.tag).first {
                try realm.write {
                    realm.delete(existingLocation)
                }
            onSuccess()
            } else {
                onError()
            }
        } catch {
            onError()
        }
    }
}
