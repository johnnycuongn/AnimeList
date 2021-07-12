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

    func fill(with viewModel: AnimeThumbnailViewModel, rank: String? = nil) {
        if let imageURL = viewModel.imageURL {
            self.animeImageView.loadUsingCache(with: imageURL)
            setNeedsLayout()
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
