//
//  Request.swift
//  ReactiveBookShop
//
//  Created by Тимур Шафигуллин on 12.05.2018.
//  Copyright © 2018 Тимур Шафигуллин. All rights reserved.
//

import Foundation
import Alamofire

protocol Request {
    var method: HTTPMethod { get }
    var endPoint: String { get }
    var parameters: [String : Any] { get }
}

