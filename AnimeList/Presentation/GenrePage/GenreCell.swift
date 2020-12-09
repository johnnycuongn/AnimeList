//
//  GenreCell.swift
//  AnimeList
//
//  Created by Johnny on 16/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    static let identifier = String(describing: GenreCell.self)
    
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        self.contentView.layer.cornerRadius = 10
    }
    
    func config(with genre: Genre) {
        self.genreLabel.text = "\(genre)"
    }
    
    func config(for title: String) {
        self.genreLabel.text = title
    }
    
}
