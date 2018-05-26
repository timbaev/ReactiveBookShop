//
//  UITextField+Valid.swift
//  ReactiveBookShop
//
//  Created by Тимур Шафигуллин on 12.05.2018.
//  Copyright © 2018 Тимур Шафигуллин. All rights reserved.
//

import UIKit

extension UITextField {
    
    func set(valid: Bool) {
        if valid {
            self.layer.borderColor = UIColor.green.cgColor
        } else {
            self.layer.borderColor = UIColor.red.cgColor
        }
    }
    
}
