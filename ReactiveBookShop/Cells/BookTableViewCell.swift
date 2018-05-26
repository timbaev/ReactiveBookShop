//
//  BookTableViewCell.swift
//  ReactiveBookShop
//
//  Created by Тимур Шафигуллин on 12.05.2018.
//  Copyright © 2018 Тимур Шафигуллин. All rights reserved.
//

import UIKit
import SDWebImage

class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func prepareCell(with book: Book) {
        coverImageView.sd_setImage(with: book.imageURL, placeholderImage: #imageLiteral(resourceName: "placeholder"))
        nameLabel.text = book.name
        authorLabel.text = book.author
        priceLabel.text = String(book.price)
    }
    
}
