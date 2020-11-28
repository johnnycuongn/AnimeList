//
//  SearchCell.swift
//  AnimeList
//
//  Created by Johnny on 16/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    static let identifier = String(describing: SearchCell.self)
    
    override func awakeFromNib() {
        self.contentView.layer.cornerRadius = 5
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var typeEpisodes: UILabel!
    @IBOutlet weak var dateReleased: UILabel!
    
    func configure(with anime: AnimeDisplayInfo) {
        self.backgroundImageView.loadUsingCache(with: anime.imageURL)
        self.imageView.loadUsingCache(with: anime.imageURL)
        
        self.titleLabel.text = anime.title
        if anime.score != nil {
            self.scoreLabel.text = "Score \(anime.score!)"
        } else {
            self.scoreLabel.text = "No Score"
        }
        
        self.membersLabel.text = "\(anime.members)"
        self.typeEpisodes.text = "\(anime.type?.rawValue ?? "") \(anime.episodes ?? 0)eps"
        self.dateReleased.text = "10/10/2020"
        
    }
}
