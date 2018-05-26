//
//  ApiProvider.swift
//  ReactiveBookShop
//
//  Created by Тимур Шафигуллин on 12.05.2018.
//  Copyright © 2018 Тимур Шафигуллин. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

class ApiProvider {
    
    private var baseURL = URL(string: "http://localhost:8080")!
    
    func makeRequest(with request: Request, completionBlock: @escaping (Data?) -> ()) {
        let url = baseURL.appendingPathComponent(request.endPoint)
        
        var encoding: ParameterEncoding = JSONEncoding.default
        if request.method == .get {
            encoding = URLEncoding.default
        }
        
        print("*** Request URL ***")
        print("Method: \(request.method)")
        print(url)
        
        Alamofire.request(url, method: request.method, parameters: request.parameters, encoding: encoding)
            .responseData { (response) in
                guard let data = response.value else { return }
                let responseString = String(data: data, encoding: .utf8)
                print("*** Start Response ***")
                print(responseString ?? "None")
                print("*** End Response ***")
                completionBlock(data)
        }
    }
    
}
