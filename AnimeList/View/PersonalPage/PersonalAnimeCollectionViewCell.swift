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
    
    var actionDelegate: PersonalAnimeActionDelegate?
    
    override func awakeFromNib() {
        
    }
    
    func configure(with anime: PersonalAnime) {
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
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        actionDelegate?.complete(self)
    }
}
