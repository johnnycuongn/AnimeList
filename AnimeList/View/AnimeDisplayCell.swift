//
//  TopAnimeCell.swift
//  AnimeList
//
//  Created by Johnny on 14/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class AnimeDisplayCell: UICollectionViewCell {
    
    static let identifier = String(describing: AnimeDisplayCell.self)
    
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
        super.awakeFromNib()
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5

        rankView.layer.cornerRadius = rankView.frame.height/3
        
        animeTitleView.layer.cornerRadius = rankView.layer.cornerRadius
    }
    
    func config(with animeInfo: AnimeDisplayInfo, rank: Int? = nil) {
        
        self.animeImageView.loadUsingCache(with: animeInfo.imageURL)
        if rank != nil {
            self.rankLabel.text = String(rank!)
        } else {
            self.rankView.isHidden = true
            self.rankLabel.isHidden = true
        }
        self.animeTitleLabel.text = animeInfo.title
        
        self.scoreLabel.text = validateLabel(animeInfo.score)
        
        self.memberLabel.text = String(animeInfo.members)
        
        self.typeEpisodeLabel.text = {
//            guard animeInfo.type != nil else { return "" }
//            guard animeInfo.episodes != nil else { return "\(animeInfo.type!.rawValue)" }
            
            let type = validateLabel(animeInfo.type?.rawValue, return: .none)
            let episode = validateLabel(animeInfo.episodes)
            
            return "\(type)(\(episode))"
        }()
        
    }
    
    
    
}