//
//  TopAnimeCell.swift
//  AnimeList
//
//  Created by Johnny on 14/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class TopAnimeCell: UICollectionViewCell {
    
    static let identifier = String(describing: TopAnimeCell.self)
    
    @IBOutlet weak var animeImageView: UIImageView!
    
    @IBOutlet weak var rankView: UIView!
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var animeTitleLabel: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var starImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        <#code#>
    }
    
    
    
}
