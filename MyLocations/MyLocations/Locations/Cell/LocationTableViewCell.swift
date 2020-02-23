//
//  LocationTableViewCell.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 15/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import AlamofireImage
import CoreLocation

class LocationTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }
    
    func configure(location: LocationModel, userLocation: CLLocationCoordinate2D?) {
        if let imageUrl = URL(string: location.imageUrl) {
            thumbnailImageView.af_setImage(withURL: imageUrl)
        }
        titleLabel.text = location.tag
        
        guard let safeUserLocation = userLocation else {
            distanceLabel.text = ""
            return
        }
        let userCoordinates = CLLocation(latitude: safeUserLocation.latitude, longitude: safeUserLocation.longitude)
        let locationCoordinates = CLLocation(latitude: CLLocationDegrees(location.latitude), longitude: CLLocationDegrees(location.longitude))
        let distance = userCoordinates.distance(from: locationCoordinates)
        distanceLabel.text = String(format: "%.2f", distance / 1000) + " km"
    }
}
