//
//  ReusePrompt.swift
//  Reuse
//
//  Created by Julian Marzabal on 04/06/2023.
//

import Foundation
import UIKit



class ReusePrompt:UIView,ViewButtonProtocol {
  
    
    var onTapped: ()->Void
    var text:String
    
    init(text: String, onTapped: @escaping ()->Void){
        self.onTapped = onTapped
        self.text = text
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = self.text
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
        
        lazy var button: UIButton = {
            let button = UIButton()
            button.setTitle("OK", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.backgroundColor = .systemGreen
            button.layer.cornerRadius = 9
            button.tintColor = .white
            button.addTarget(self, action: #selector(goToRegisterView), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        
        
        
        private func configureView() {
               backgroundColor = .systemGray
               layer.cornerRadius = 8
               layer.shadowColor = UIColor.black.cgColor
               layer.shadowOpacity = 0.2
               layer.shadowOffset = CGSize(width: 0, height: 2)
               layer.shadowRadius = 4
            layer.borderColor = UIColor.systemGreen.cgColor
            layer.borderWidth = 1
            
               
               addSubview(label)
               addSubview(button)
               setContraints()
           }
        private func setContraints() {
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                
                button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 24),
                button.centerXAnchor.constraint(equalTo: centerXAnchor),
                button.widthAnchor.constraint(equalToConstant: 80),
                button.heightAnchor.constraint(equalToConstant: 44),
                button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
        }
    @objc private func goToRegisterView() {
        onTapped()
    }
    
    
    
}
