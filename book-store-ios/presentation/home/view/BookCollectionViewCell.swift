//
//  BookCollectionViewCell.swift
//  test-book-store
//
//  Created by Federico Ventre on 30/04/2022.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var coverBook: UIImageView!
    @IBOutlet weak var authorBook: UILabel!
    @IBOutlet weak var titleBook: UILabel!
    var model: Book?
    
    func configure(model: Book) {
        self.model = model
        setupViewCell()
        setup(with: model)
    }
    
    func setupViewCell(){
        self.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.borderWidth = 1.0

        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }
    
    func setup(with model: Book) {
        titleBook.text = model.title
        authorBook.text = model.author
        if let url = URL(string: model.image) {
            self.coverBook.setImageFrom(url: url)
        }else{
            self.coverBook.image = UIImage(systemName: "photo.fill")
        }
    }
    
}
