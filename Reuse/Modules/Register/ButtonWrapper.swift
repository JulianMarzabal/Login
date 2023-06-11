//
//  ButtonWrapper.swift
//  Reuse
//
//  Created by Julian Marzabal on 08/06/2023.
//

import Foundation
import UIKit

typealias ButtonHandler = () -> Void
struct ButtonWrapperModel {
    let buttonTitle: String
    let handler: ButtonHandler?
}



class ButtonWrapper: UITableViewCell {
    static let identifier = "ButtonWrapper"
    private var title: String = "" {
        didSet{
            button.configuration?.title = title
        }
    }
    private var handler: ButtonHandler?
    
    private lazy var  button: UIButton = {
        var config = UIButton.Configuration.filled()
        
        let button = UIButton(type: .system)
        button.configuration = config
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
       return button
    }()
    
    public func configure(model:ButtonWrapperModel){
        self.title = model.buttonTitle
        self.handler = model.handler
        configureUI()
        
    }
    
    
    
    
    private func configureUI() {
        contentView.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
     @objc private func pressButton() {
        handler?()
    }
    
    
    
    
    
}
