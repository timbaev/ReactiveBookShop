//
//  Book.swift
//  ReactiveBookShop
//
//  Created by Тимур Шафигуллин on 12.05.2018.
//  Copyright © 2018 Тимур Шафигуллин. All rights reserved.
//

import Foundation

struct Book: Codable, Hashable {
    
    let id: Int
    let name: String
    let author: String
    let price: Double
    let imageURL: URL
    
}
