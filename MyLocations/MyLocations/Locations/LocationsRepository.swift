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
                onSuccess(result)
            } catch {
                onError()
            }
        }
    }
}
