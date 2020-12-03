//
//  PersonalAnimeCollectionViewCell.swift
//  AnimeList
//
//  Created by Johnny on 5/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

protocol PersonalAnimeActionDelegate {
    func complete(_ cell: PersonalAnimeCollectionViewCell)
    
    func delete(_ cell: PersonalAnimeCollectionViewCell)
}

class PersonalAnimeCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: PersonalAnimeCollectionViewCell.self)
    
    @IBOutlet weak var animeImageView: UIImageView!
    @IBOutlet weak var animeTitle: UILabel!
    
    @IBOutlet weak var removeVisualView: UIVisualEffectView!
    
    var actionDelegate: PersonalAnimeActionDelegate?
    
    override func awakeFromNib() {
        animeImageView.contentMode = .scaleAspectFill
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 5
        
        removeVisualView.layer.cornerRadius = removeVisualView.frame.height/2
        removeVisualView.clipsToBounds = true
    }
    
    func configure(with anime: PersonalAnimeEntity) {
        if anime.image != nil {
            DispatchQueue.main.async {
                self.animeImageView.image = UIImage(data: anime.image!)
            }
        }
        
        self.animeTitle.text = anime.title
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        actionDelegate?.delete(self)
    }
}
