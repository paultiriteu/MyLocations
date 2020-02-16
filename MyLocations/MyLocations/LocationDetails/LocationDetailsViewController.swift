//
//  LocationDetailsViewController.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 16/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    
    private let viewModel: LocationDetailsViewModel
    
    init(viewModel: LocationDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "LocationDetailsViewController", bundle: Bundle(for: LocationDetailsViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        let location = viewModel.location
        titleLabel.text = location.tag
        addressLabel.text = location.address
        coordinatesLabel.text = "Latitude: \(location.latitude ?? 0)\nLongitude: \(location.longitude ?? 0)"
        
        guard let safeUrl = URL(string: viewModel.location.imageUrl ?? "") else {
            return
        }
        imageView.af_setImage(withURL: safeUrl)
    }
}
