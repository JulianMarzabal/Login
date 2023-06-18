//
//  TextFieldWrapper.swift
//  Reuse
//
//  Created by Julian Marzabal on 08/06/2023.
//

import Foundation
import UIKit

typealias TextHandler = (String)->Void
struct TextFieldWrapperModel {
    let placeholderText:String
    let handler: TextHandler?
    let inputType: InputType
    
}

enum InputType {
    case name
    case surname
    case email
    case password
    case anyType
    var isSecure:Bool {
        switch self {
      
        case .password:
            return true
        default:
            return false
        }
    }
    var validator: Validator {
        switch self {
            
        case .name:
            return ValidateName()
        case .surname:
            return ValidateName()
        case .email:
            return ValidateEmail()
        case .password:
            return ValidatePassword()
        
        case .anyType:
            return ValidateTrue()
        }
        
    }
    
}


class TextFieldWrapper:UITableViewCell {
    static let identifier = "TextFieldWrapper"
    private var placeholderText:String = "" {
        didSet {
            textField.placeholder = placeholderText
        }
    }
    private var  handler: TextHandler?
    private var inputType: InputType = .anyType
    private var validator: Validator {
        inputType.validator
    }
    private var separator:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    
     public func configure(model:TextFieldWrapperModel) {
        self.placeholderText = model.placeholderText
        self.handler = model.handler
         self.inputType = model.inputType
         self.textField.isSecureTextEntry = model.inputType.isSecure
         
        
         
         configureUI()
         
    }
    
    private func configureUI() {
        contentView.addSubview(textField)
        contentView.addSubview(separator)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: separator.topAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
          
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textField.leftViewMode = .always
        textField.delegate = self
//        textField.layer.cornerRadius = 5
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.layer.borderWidth = 0.5
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
}
extension TextFieldWrapper: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard validator.validateEntry(text: string) else {
            return false
        }
        let text = textField.text ?? ""
       
        if let range = Range(range, in: text) {
            let newString = text.replacingCharacters(in: range, with: string)
            if validator.validate(text: newString) {
                handler?(newString)
            } else {
                handler?("")
            }
           
            
            
        }
        return true
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        guard let text = textField.text else {return}
//        if validator.validate(text: text) {
//            textField.textColor = .black
//        } else {
//            textField.textColor = .red
//        }
//
//    }
    
    
}
