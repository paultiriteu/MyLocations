//
//  FormFieldTableViewCell.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 22/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import UIKit

class FormFieldTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var fieldName: FormField = .tag
    private var textFieldValue: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        selectionStyle = .none
    }
    
    func configure(fieldName: FormField, value: String) {
        self.fieldName = fieldName
        titleLabel.text = fieldName.rawValue
        textField.text = value
        textField.placeholder = "Insert a \(fieldName)"
    }
    
    func getValue() -> String {
        textFieldDidEndEditing(textField)
        return textFieldValue
    }
}

extension FormFieldTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldValue = textField.text ?? ""
    }
}
