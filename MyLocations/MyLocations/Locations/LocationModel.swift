//
//  LocationModel.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 15/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import RealmSwift

class LocationModel: Object, Codable {
    @objc dynamic var latitude: Float = 0.0
    @objc dynamic var longitude: Float = 0.0
    @objc dynamic var tag: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var imageUrl: String = ""
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "long"
        case tag
        case address
        case imageUrl = "img"
    }
}
