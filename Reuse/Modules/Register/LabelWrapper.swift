//
//  LabelWrapper.swift
//  Reuse
//
//  Created by Julian Marzabal on 08/06/2023.
//

import Foundation
import UIKit

struct LabelWrapperModel {
    let text: String
    let handler: TextHandler?
}


class LabelWrapper:UITableViewCell {
    static let identifier = "LabelWrapper"
    private var text: String = ""{
        didSet{
            titleLabel.text = text
        }
    }
    
    private var handler: TextHandler?
    
    public func configure(model:LabelWrapperModel){
        self.text = model.text
        self.handler = model.handler
        configureUI()
    }
    
    
    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()
    
    private func configureUI() {
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    
    
    
    
    
    
    
    
}
