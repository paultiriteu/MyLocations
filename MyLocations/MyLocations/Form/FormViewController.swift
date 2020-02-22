//
//  FormViewController.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 22/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    @IBOutlet weak var formTableView: UITableView!
    @IBOutlet weak var button: UIButton!
    
    private let viewModel: FormViewModel
    
    @IBAction func buttonAction(_ sender: Any) {
        viewModel.sendForm()
    }
    
    init(viewModel: FormViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "FormViewController", bundle: Bundle(for: FormViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formTableView.delegate = self
        formTableView.dataSource = self
        formTableView.register(UINib(nibName: "FormFieldTableViewCell", bundle: Bundle(for: FormFieldTableViewCell.self)), forCellReuseIdentifier: "FormFieldTableViewCell")
        
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        title = viewModel.location?.tag
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        title = ""
    }
    
    private func configureUI() {
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        switch viewModel.formPurpose {
        case .addLocation:
            button.setTitle("Add location", for: .normal)
            button.backgroundColor = UIColor(red: 100/255, green: 205/255, blue: 100/255, alpha: 1)
        case .editLocation:
            button.setTitle("Edit location", for: .normal)
            button.backgroundColor = .blue
        }
        formTableView.tableFooterView = UIView(frame: .zero)
    }
}

extension FormViewController: UITableViewDelegate {
    
}

extension FormViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.location == nil ? viewModel.locationFields.count : viewModel.locationFields.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FormFieldTableViewCell") as? FormFieldTableViewCell else {
            return UITableViewCell()
        }
        
        var field = ""
        if let location = viewModel.location {
            field = viewModel.locationFields[indexPath.row + 1]
            if field == "Address" {
                cell.configure(fieldName: "Address", value: location.address)
            }
            
            if field == "Image URL" {
                cell.configure(fieldName: "Image URL", value: location.imageUrl)
            }
            
            if field == "Latitude" {
                cell.configure(fieldName: "Latitude", value: "\(location.latitude)")
            }
            
            if field == "Longitude" {
                cell.configure(fieldName: "Longitude", value: "\(location.longitude)")
            }
        }  else {
            field = viewModel.locationFields[indexPath.row]
            cell.configure(fieldName: field, value: "")
        }
        viewModel.formCells.append(cell)
        return cell
    }
}
