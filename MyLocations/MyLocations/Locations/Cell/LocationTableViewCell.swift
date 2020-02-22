//
//  LocationTableViewCell.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 15/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import AlamofireImage

class LocationTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(location: LocationModel) {
        if let imageUrl = URL(string: location.imageUrl) {
            thumbnailImageView.af_setImage(withURL: imageUrl)
        }
        titleLabel.text = location.tag
    }
    
}
