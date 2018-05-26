//
//  Validator.swift
//  ReactiveBookShop
//
//  Created by Тимур Шафигуллин on 12.05.2018.
//  Copyright © 2018 Тимур Шафигуллин. All rights reserved.
//

import Foundation

class Validator {
    
    static func phoneNumber(_ number: String?) -> Bool {
        guard let number = number else { return false }
        let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: number)
    }
    
    static func dateExparation(_ date: String?) -> Bool {
        guard let date = date else { return false }
        let dateRegex = "\\d{2}\\/\\d{2}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", dateRegex)
        return predicate.evaluate(with: date)
    }
    
    static func cvvCode(_ code: String?) -> Bool {
        guard let code = code else { return false }
        let cvvRegex = "\\d{3}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", cvvRegex)
        return predicate.evaluate(with: code)
    }
    
}
