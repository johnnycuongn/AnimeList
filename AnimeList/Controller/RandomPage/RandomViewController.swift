//
//  RandomViewController.swift
//  AnimeList
//
//  Created by Johnny on 3/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController {
    
    @IBOutlet weak var descriptionScrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIVisualEffectView!
    
    @IBOutlet weak var animeImageView: UIImageView!
    
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var animeSynopsis: UILabel!
    @IBOutlet weak var animeRank: UILabel!
    @IBOutlet weak var animePopularity: UILabel!
    @IBOutlet weak var animeScore: UILabel!
    @IBOutlet weak var animeMembers: UILabel!
    @IBOutlet weak var animeStudio: UILabel!
    @IBOutlet weak var animeTypeEpisode: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadAnime()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadAnime()
    }
    
    override func viewDidLayoutSubviews() {
        descriptionScrollView.contentInset.bottom = bottomView.frame.height
    }
    
    private func loadAnime() {
        let startTime = NSDate()
        
        RecommendService.shared.recommendID { (id) in
            AnimeInfoService.shared.fetchAnime(id: id) { [weak self] (animeInfo) in
                guard let strongSelf = self else { return }
                
                DispatchQueue.main.async {
                    if animeInfo.imageURL == nil { strongSelf.animeImageView.isHidden = true }
                    else {
                        strongSelf.animeImageView.loadUsingCache(with: animeInfo.imageURL!)
                    }
                    
                    strongSelf.animeTitle.text = animeInfo.title
                    strongSelf.animeSynopsis.text = animeInfo.synopsis

                    strongSelf.animeRank.text = "#\(strongSelf.validateLabel(animeInfo.rank))"
                    strongSelf.animePopularity.text = "#\(strongSelf.validateLabel(animeInfo.popularity))"
                    
                    strongSelf.animeScore.text = "\(strongSelf.validateLabel(animeInfo.score))"
                    strongSelf.animeMembers.text = "\(strongSelf.validateLabel( animeInfo.members))"
                    
                    strongSelf.animeStudio.text = "Studio"
                    strongSelf.animeTypeEpisode.text = "\(animeInfo.type.rawValue)(\(strongSelf.validateLabel(animeInfo.episodes)))"
                }
                let endTime = NSDate()
                print("Fetch && Display Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
            }
        }
    }

    @IBAction func nextBtnTapped(_ sender: Any) {
        loadAnime()
    }
    
    // MARK: Helper
    func validateLabel<T>(_ label: T?) -> String {
        if label == nil { return "-" }
        
        return String(describing: label!)
    }
    
}
