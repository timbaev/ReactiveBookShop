//
//  ShoppingCart.swift
//  ReactiveBookShop
//
//  Created by Тимур Шафигуллин on 12.05.2018.
//  Copyright © 2018 Тимур Шафигуллин. All rights reserved.
//

import Foundation
import RxSwift

class ShoppingCart {
    
    static let shared = ShoppingCart()
    
    var selectedBooks: Variable<Set<Book>> = Variable(Set<Book>())
    
}
