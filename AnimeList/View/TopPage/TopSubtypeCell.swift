//
//  TopSubtypeCell.swift
//  AnimeList
//
//  Created by Johnny on 14/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class TopSubtypeCell: UICollectionViewCell {
    
    @IBOutlet weak var topSubtypeLabel: UILabel!
    
    static let identifier = String(describing: TopSubtypeCell.self)
    
    override func awakeFromNib() {
    }
    
    func config(with subtype: AnimeTopSubtype) {
        topSubtypeLabel.text = subtype.rawValue
    }
    
    
    
    
}
