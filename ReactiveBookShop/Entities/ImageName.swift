//
//  ImageName.swift
//  ReactiveBookShop
//
//  Created by Тимур Шафигуллин on 12.05.2018.
//  Copyright © 2018 Тимур Шафигуллин. All rights reserved.
//

import UIKit

enum ImageName: String {
    case
    Amex,
    Discover,
    Mastercard,
    Visa,
    UnknownCard
    
    var image: UIImage {
        guard let image = UIImage(named: self.rawValue) else {
            fatalError("Image not found for name \(self.rawValue)")
        }
        
        return image
    }
}
