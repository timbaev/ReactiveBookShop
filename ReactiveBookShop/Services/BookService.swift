//
//  BookService.swift
//  ReactiveBookShop
//
//  Created by Тимур Шафигуллин on 12.05.2018.
//  Copyright © 2018 Тимур Шафигуллин. All rights reserved.
//

import Foundation

class BookService {
    
    func fetchAllBooks(success: @escaping ([Book]) -> Void, failure: @escaping (String) -> Void) {
        let request = FetchBooksRequest()
        ApiProvider().makeRequest(with: request) { (data) in
            guard let data = data else { return }
            
            if let books = try? JSONDecoder().decode([Book].self, from: data) {
                success(books)
            } else {
                failure("Error fetch books. Something went wrong :(")
            }
        }
    }
    
}
