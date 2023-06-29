//
//  ValidateFormStrategy.swift
//  Reuse
//
//  Created by Julian Marzabal on 11/06/2023.
//

import Foundation
import SwiftUI



protocol Validator{
    func validate(text:String) -> Bool
    func validateEntry(text:String) -> Bool
}

struct ValidateTrue:Validator {
    func validateEntry(text: String) -> Bool {
        return true
    }
    
    func validate(text: String) -> Bool {
        return true
    }
    
    
}


struct ValidateEmail: Validator {
    func validateEntry(text: String) -> Bool {
        return true
    }
    
    func validate(text:String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: text)
    }
    
}


struct ValidatePassword: Validator {
    func validateEntry(text: String) -> Bool {
        return true
    }
    
    func validate(text:String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*\\d).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: text)
    }
}
struct ValidateName: Validator {
    func validateEntry(text: String) -> Bool {
        
        text == " " || Int(text) == nil
    }
    
    func validate(text:String) -> Bool {
        guard !text.isEmpty else {
            return false
        }
   
        let nameRegex = "^[a-zA-ZáÁéÉíÍóÓúÚüÜñÑ ]+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        return namePredicate.evaluate(with: text)
    }
    
}




