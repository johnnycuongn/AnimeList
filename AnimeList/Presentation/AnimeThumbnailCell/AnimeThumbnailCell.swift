//
//  TopAnimeCell.swift
//  AnimeList
//
//  Created by Johnny on 14/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class AnimeThumbnailCell: UICollectionViewCell {
    
    static let identifier = String(describing: AnimeThumbnailCell.self)
    
    static let size: CGSize = CGSize(
        width: UIScreen.main.bounds.width / 2.2,
        height: UIScreen.main.bounds.height / 3)

    
    
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
    
    func config(with animeInfo: AnimeThumbnailDTO, rank: Int? = nil) {
        if let imageURL = animeInfo.imageURL {
            self.animeImageView.loadUsingCache(with: imageURL)
        }
        
        if rank != nil {
            self.rankLabel.text = String(rank!)
        } else {
            self.rankView.isHidden = true
            self.rankLabel.isHidden = true
        }
        self.animeTitleLabel.text = animeInfo.title
        
        if animeInfo.score == 0 {
            self.scoreLabel.text = "-"
        }
        else {
            self.scoreLabel.text = validateLabel(animeInfo.score)
        }
        
        self.memberLabel.text = validateLabel(animeInfo.members)
        
        self.typeEpisodeLabel.text = {
//            guard animeInfo.type != nil else { return "" }
//            guard animeInfo.episodes != nil else { return "\(animeInfo.type!.rawValue)" }
            
            let type = validateLabel(animeInfo.type?.rawValue, return: .none)
            let episode = validateLabel(animeInfo.episodes)
            
            return "\(type)(\(episode))"
        }()
    }
    
    func fill(with viewModel: AnimeThumbnailViewModel, rank: String? = nil) {
        if let imageURL = viewModel.imageURL {
            self.animeImageView.loadUsingCache(with: imageURL)
        }
        
        if rank != nil {
            self.rankLabel.text = rank!
        } else {
            self.rankView.isHidden = true
            self.rankLabel.isHidden = true
        }
        
        self.animeTitleLabel.text = viewModel.title
        self.scoreLabel.text = viewModel.score
        self.memberLabel.text = viewModel.members
        self.typeEpisodeLabel.text = "\(viewModel.type)(\(viewModel.episode))"
    }
    
    
    
}
