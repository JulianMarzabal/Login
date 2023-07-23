//
//  TextFieldWrapper.swift
//  Reuse
//
//  Created by Julian Marzabal on 08/06/2023.
//

import Foundation
import UIKit
import XCTest

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
    var isVisible:Bool {
        switch self {
        case .password:
            return false
        default:
            return true
        }
    
    }
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
         if model.inputType == .password {
             displayEyeIcon()
         } else {
             ""
         }
         
    }
    
    private func configureUI() {
        contentView.backgroundColor = .backgroundColor
        contentView.addSubview(textField)
        contentView.addSubview(separator)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: separator.topAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
          
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.alpha = 1
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        textField.leftViewMode = .always
        textField.delegate = self
        textField.backgroundColor = .backgroundColor
//        textField.layer.cornerRadius = 5
//        textField.layer.borderColor = UIColor.black.cgColor
//        textField.layer.borderWidth = 0.5
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .default
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
     lazy var eyeIcon: UIImageView = {
         let eyeImage = UIImage(systemName: "eye")
         let image = UIImageView(image: eyeImage)
         image.backgroundColor = .backgroundColor
         image.tintColor = .black
         image.translatesAutoresizingMaskIntoConstraints = false
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
         image.addGestureRecognizer(tapGesture)
         image.isUserInteractionEnabled = true
         
         return image
    }()
    
    func displayEyeIcon() {
        contentView.addSubview(eyeIcon)
        NSLayoutConstraint.activate([
            eyeIcon.leadingAnchor.constraint(equalTo: textField.trailingAnchor,constant: 1),
            eyeIcon.topAnchor.constraint(equalTo: textField.topAnchor),
            eyeIcon.bottomAnchor.constraint(equalTo: textField.bottomAnchor),
        
            eyeIcon.heightAnchor.constraint(lessThanOrEqualToConstant: 30),
            eyeIcon.widthAnchor.constraint(lessThanOrEqualToConstant: 30)
                    
           
        ])
        
    }
    
    @objc private func imageTapped() {
        textField.isSecureTextEntry.toggle()
        eyeIcon.image = textField.isSecureTextEntry ? UIImage(systemName: "eye.slash") : UIImage(systemName: "eye")

    }
    
    
    

    
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
