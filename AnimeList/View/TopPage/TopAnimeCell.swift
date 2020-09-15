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
    
    @IBOutlet weak var animeTitleView: UIView!
    @IBOutlet weak var animeTitleLabel: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var scoreImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var memberImageView: UIImageView!
    @IBOutlet weak var memberLabel: UILabel!
    
    @IBOutlet weak var typeEpisodeLabel: UILabel!
    
    override func awakeFromNib() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5

        rankView.layer.cornerRadius = rankView.frame.height/3
        
        animeTitleView.layer.cornerRadius = rankView.layer.cornerRadius
    }
    
    func config(with animeInfo: TopAnime) {
        
        self.animeImageView.loadUsingCache(with: animeInfo.imageURL)
        
        self.rankLabel.text = String(animeInfo.rank)
        self.animeTitleLabel.text = animeInfo.title
        
        if animeInfo.score == 0 { self.scoreLabel.text = "-" }
        else {
            self.scoreLabel.text = String(animeInfo.score)
        }
        
        self.memberLabel.text = String(animeInfo.members)
        
        self.typeEpisodeLabel.text = {
            guard animeInfo.type != nil else { return "" }
            guard animeInfo.episodes != nil else { return "\(animeInfo.type!.rawValue)" }
            
            return "\(animeInfo.type!.rawValue)(\(animeInfo.episodes!))"
        }()
        
    }
    
    
    
}
