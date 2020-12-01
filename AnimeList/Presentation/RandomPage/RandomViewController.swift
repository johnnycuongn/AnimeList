//
//  RandomViewController.swift
//  AnimeList
//
//  Created by Johnny on 3/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Outlets
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
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var genreCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - View Controller's Variables
    var anime: AnimeDetailsDTO?
    private var isAnimeSaved: Bool = false {
        didSet {
            if isAnimeSaved == true {
                saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }
            else {
                saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            }
        }
    }
    
    // MARK: - Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAnime()
        descriptionScrollView.delegate = self
        
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        loadAnime()
    }
    
    override func viewDidLayoutSubviews() {
        randomAnimeView.layer.cornerRadius = 7
        
        let height = genreCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        genreCollectionViewHeight.constant = height
        self.view.layoutIfNeeded()
        
        descriptionScrollView.contentInset.bottom = bottomView.frame.height
        descriptionScrollView.contentInset.top = randomAnimeView.frame.height/2 + 50
        
        saveButton.layer.cornerRadius = 5
    }

    
    private func loadAnime() {
        let startTime = NSDate()
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        RecommendService.shared.recommendID { (id) in
            AnimeInfoService.shared.fetchAnime(id: id) { [weak self] (animeInfo) in
                guard let strongSelf = self else { return }
                
                DispatchQueue.main.async {
                    if animeInfo.imageURL == nil { strongSelf.animeImageView.isHidden = true }
                    else {
                        strongSelf.animeImageView.loadUsingCache(with: animeInfo.imageURL!)
                    }
                    
                    strongSelf.animeTitle.text = animeInfo.title
                    strongSelf.animeSynopsis.text = validateLabel(animeInfo.synopsis, return: .none)

                    strongSelf.animeRank.text = "#\(validateLabel(animeInfo.rank))"
                    strongSelf.animePopularity.text = "#\(validateLabel(animeInfo.popularity))"
                    
                    strongSelf.animeScore.text = "\(validateLabel(animeInfo.score))"
                    strongSelf.animeMembers.text = "\(validateLabel( animeInfo.members))"
                    
                    strongSelf.animeStudio.text = "\(validateLabel(animeInfo.studios[0].name))"
                    strongSelf.animeTypeEpisode.text = "\(animeInfo.type.rawValue)(\(validateLabel(animeInfo.episodes)))"
                    
                    strongSelf.anime = animeInfo
                    strongSelf.genreCollectionView.reloadData()
                }
                let endTime = NSDate()
                print("Random: Fetch && Display Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
                strongSelf.activityIndicator.stopAnimating()
                
            }
            
            PersonalAnimeDataManager.isIDExist(id) {[weak self] isExisted in
                if isExisted {
                    self?.isAnimeSaved = true
                } else {
                    self?.isAnimeSaved = false
                }
            }
        }
    }
    
    // MARK: - Buttons Action
    @IBAction func nextBtnTapped(_ sender: Any) {
        loadAnime()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let currentAnime = anime else {
            return
        }
        
        if isAnimeSaved == false {
            PersonalAnimeDataManager.add(id: currentAnime.malID,
                                         image: self.animeImageView.image,
                                         title: currentAnime.title, date: Date())
            isAnimeSaved = true
        }
        else {
            PersonalAnimeDataManager.remove(id: currentAnime.malID)
            isAnimeSaved = false
        }
    }
    
}

extension RandomViewController: UICollectionViewDelegateFlowLayout {
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension RandomViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard anime != nil else {return 0}
        
        return anime!.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard anime != nil else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimeGenreCollectionViewCell.identifier, for: indexPath) as! AnimeGenreCollectionViewCell
        
        cell.configure(with: anime!.genres[indexPath.row].name)
        
        return cell
    }
}
