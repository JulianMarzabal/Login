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
    
}


class TextFieldWrapper:UITableViewCell {
    static let identifier = "TextFieldWrapper"
    private var placeholderText:String = "" {
        didSet {
            textField.placeholder = placeholderText
        }
    }
    private var  handler: TextHandler?
    
    
    
     public func configure(model:TextFieldWrapperModel) {
        self.placeholderText = model.placeholderText
        self.handler = model.handler
         configureUI()
         
    }
    
    private func configureUI() {
        contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
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
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
}
extension TextFieldWrapper: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
       
        if let range = Range(range, in: text) {
            let newString = text.replacingCharacters(in: range, with: string)
            
            handler?(newString)
            
            
        }
        return true
    }
    
}
