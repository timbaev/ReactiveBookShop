//
//  FetchBooksRequest.swift
//  ReactiveBookShop
//
//  Created by Тимур Шафигуллин on 12.05.2018.
//  Copyright © 2018 Тимур Шафигуллин. All rights reserved.
//

import Foundation
import Alamofire

class FetchBooksRequest: Request {
    
    var method: HTTPMethod = .get
    var endPoint = "books"
    var parameters = [String : Any]()
    
}
