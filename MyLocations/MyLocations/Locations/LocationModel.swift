//
//  LocationModel.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 15/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import Foundation

struct LocationModel: Codable {
    var latitude: Double?
    var longitude: Double?
    var tag: String?
    var address: String?
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "long"
        case tag
        case address
        case imageUrl = "img"
    }
}
