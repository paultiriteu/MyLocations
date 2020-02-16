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
            guard let data = response.data else {
                onError()
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode([LocationModel].self, from: data)
                
                try result.forEach { location in
                    try self?.realm.write {
                        let realmLocation = RealmLocation()
                        realmLocation.latitude = location.latitude ?? 0
                        realmLocation.longitude = location.longitude ?? 0
                        realmLocation.tag = location.tag ?? ""
                        realmLocation.address = location.address ?? ""
                        realmLocation.imageUrl = location.imageUrl ?? ""
                        
                        self?.realm.add(realmLocation)
                    }
                }
                
                onSuccess(result)
            } catch {
                onError()
            }
        }
    }
}
