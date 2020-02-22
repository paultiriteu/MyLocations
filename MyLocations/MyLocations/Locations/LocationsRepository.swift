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
    private var observer: NotificationToken?
    
    init() {
        self.realm = try! Realm()
    }
    
    func loadLocations(onError: @escaping () -> Void) {
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
                        if self.realm.objects(LocationModel.self).filter("tag = %@", location.tag).isEmpty {
                            self.realm.add(location, update: .all)
                        }
                    }
                }
            } catch {
                onError()
            }
        }
    }
    
    func observeRealmLocations(didChange: @escaping ([LocationModel]) -> Void) {
        observer?.invalidate()
        observer = realm.objects(LocationModel.self).observe { (change) in
            let models: [LocationModel]
            switch change {
            case .initial(let initial):
                models = Array(initial)
            case .error(let error):
                print(error)
                models = []
            case .update(let updated, _, _, _):
                models = Array(updated)
            }
            didChange(models)
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
    
    deinit {
        observer?.invalidate()
    }
}
