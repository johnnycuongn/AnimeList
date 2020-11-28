//
//  GenreCollectionViewCell.swift
//  AnimeList
//
//  Created by Johnny on 4/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: GenreCollectionViewCell.self)
    
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        layer.cornerRadius = 5
    }
    
    func configure(with genre: String) {
        genreLabel.text = genre
    }
    
}
