//
//  RandomViewController.swift
//  AnimeList
//
//  Created by Johnny on 3/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var randomAnimeView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var visualEffectAnimeView: UIVisualEffectView!
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
        loadAnime()
        descriptionScrollView.delegate = self
        visualEffectAnimeView.effect = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        loadAnime()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 5) {
            self.visualEffectAnimeView.effect = UIBlurEffect(style: .systemThinMaterialDark)
        }
    }
    
    override func viewDidLayoutSubviews() {
        descriptionScrollView.contentInset.bottom = bottomView.frame.height
        descriptionScrollView.contentInset.top = randomAnimeView.frame.height/2 + 50
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

                    strongSelf.animeRank.text = "#\(validateLabel(animeInfo.rank))"
                    strongSelf.animePopularity.text = "#\(validateLabel(animeInfo.popularity))"
                    
                    strongSelf.animeScore.text = "\(validateLabel(animeInfo.score))"
                    strongSelf.animeMembers.text = "\(validateLabel( animeInfo.members))"
                    
                    strongSelf.animeStudio.text = "Studio"
                    strongSelf.animeTypeEpisode.text = "\(animeInfo.type.rawValue)(\(validateLabel(animeInfo.episodes)))"
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

}
