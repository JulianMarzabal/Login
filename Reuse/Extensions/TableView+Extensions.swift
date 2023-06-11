//
//  TableView+Extensions.swift
//  Reuse
//
//  Created by Julian Marzabal on 08/06/2023.
//

import Foundation
import UIKit

extension UITableView {
    func registerCells() {
        
        self.register(TextFieldWrapper.self, forCellReuseIdentifier: TextFieldWrapper.identifier)
       
    }
    
   
}
