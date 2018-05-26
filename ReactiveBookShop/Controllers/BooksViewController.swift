//
//  ViewController.swift
//  ReactiveBookShop
//
//  Created by Тимур Шафигуллин on 12.05.2018.
//  Copyright © 2018 Тимур Шафигуллин. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BooksViewController: UIViewController {
    
    @IBOutlet weak var booksCartButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var books: Variable<[Book]> = Variable([Book]())
    let bookCellIdentifier = "bookCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        setupCellConfiguration()
        setupCellTapHendling()
        setupCartObserver()
        fetchBooks()
    }
    
    func setupCartObserver() {
        ShoppingCart.shared.selectedBooks.asObservable()
            .subscribe(onNext: { (selectedBooks) in
            self.booksCartButtonItem.title = "\(selectedBooks.count) 📕"
        })
            .disposed(by: disposeBag)
    }
    
    func setupCellConfiguration() {
        books.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: bookCellIdentifier, cellType: BookTableViewCell.self)) { (row, book, cell) in
            cell.prepareCell(with: book)
        }
        .disposed(by: disposeBag)
    }
    
    func setupCellTapHendling() {
        tableView
            .rx
            .modelSelected(Book.self)
            .subscribe(onNext: { (book) in
                ShoppingCart.shared.selectedBooks.value.insert(book)
                if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: selectedIndexPath, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func prepareTableView() {
        let nib = UINib(nibName: "BookTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: bookCellIdentifier)
        tableView.estimatedRowHeight = 130
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func fetchBooks() {
        let booksService = BookService()
        booksService.fetchAllBooks(success: { [weak self] (books) in
            guard let strongSelf = self else { return }
            strongSelf.books.value = books
            strongSelf.tableView.reloadData()
        }) { (errorMessage) in
            print("*** Error ***")
            print(errorMessage)
        }
    }

}
