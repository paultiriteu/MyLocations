//
//  RealmLocation.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 16/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import RealmSwift

class RealmLocation: Object {
    @objc dynamic var latitude: Float = 0.0
    @objc dynamic var longitude: Float = 0.0
    @objc dynamic var tag: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var imageUrl: String = ""
}
