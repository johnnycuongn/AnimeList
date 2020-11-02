//
//  RandomViewController.swift
//  AnimeList
//
//  Created by Johnny on 3/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController {

    @IBOutlet weak var animeImageView: UIImageView!
    
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var animeSynopsis: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAnime()
    }
    
    private func loadAnime() {
        let randomID = Int.random(in: 1..<7500)
        
        AnimeInfoService.shared.fetchAnime(id: randomID) { [weak self] (animeInfo) in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                if animeInfo.imageURL == nil { strongSelf.animeImageView.isHidden = true }
                else {
                    strongSelf.animeImageView.loadUsingCache(with: animeInfo.imageURL!)
                }
                
                strongSelf.animeTitle.text = animeInfo.title
                strongSelf.animeSynopsis.text = animeInfo.synopsis
            }
        }
        
    }

    @IBAction func nextBtnTapped(_ sender: Any) {
        loadAnime()
    }
    
}
