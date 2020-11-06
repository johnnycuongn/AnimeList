//
//  AnimeViewController.swift
//  AnimeList
//
//  Created by Johnny on 24/10/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class AnimeViewController: UIViewController {
    
    static func initialize(with id: Int) -> AnimeViewController? {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let animeVC = storyBoard.instantiateViewController(withIdentifier: "AnimeViewController") as? AnimeViewController else { return nil }
        animeVC.id = id
        animeVC.modalPresentationStyle = .overFullScreen
        
        return animeVC
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backgroundAnimeImage: UIImageView!
    @IBOutlet weak var animeImage: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreLabelView: UIView!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    @IBOutlet weak var studioLabel: UILabel!
    @IBOutlet weak var premieredLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var typeEpisodesLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
   
    @IBOutlet weak var animeTitleLabel: UILabel!
    @IBOutlet weak var animeEngTitleLabel: UILabel!
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    private var id: Int = 0
    
    private var anime: AnimeInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        
        scoreLabelView.layer.cornerRadius = 7
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadAnime(id: self.id)
    }
    
    func loadAnime(id: Int) {
        activityIndicator.startAnimating()
        AnimeInfoService.shared.fetchAnime(id: id) { [weak self] (animeInfo) in
            print("Anime Fetched: \(animeInfo.title) - \(animeInfo.url)")
            guard let strongSelf = self else {return}
            DispatchQueue.main.async {
                if animeInfo.imageURL != nil {
                    strongSelf.animeImage.loadUsingCache(with: animeInfo.imageURL!)
//                    strongSelf.backgroundAnimeImage.image = strongSelf.animeImage.image
                }
                
                strongSelf.scoreLabel.text = validateLabel(animeInfo.score)
                strongSelf.rankLabel.text = "#\(validateLabel(animeInfo.rank))"
                strongSelf.popularityLabel.text = "#\(validateLabel(animeInfo.popularity))"
                strongSelf.membersLabel.text = validateLabel(animeInfo.members)
                strongSelf.favoritesLabel.text = validateLabel(animeInfo.favorites)
                
                strongSelf.studioLabel.text = validateLabel(animeInfo.studios[0].name)
                strongSelf.typeEpisodesLabel.text = "\(validateLabel(animeInfo.type.rawValue, return: .none))(\(validateLabel(animeInfo.episodes)))"
                
                strongSelf.premieredLabel.text = validateLabel(animeInfo.premieredDate)
                strongSelf.statusLabel.text = validateLabel( animeInfo.status)
                
                strongSelf.ratingLabel.text = validateLabel(animeInfo.rating)
                strongSelf.animeTitleLabel.text = validateLabel(animeInfo.title)
                strongSelf.animeEngTitleLabel.text = validateLabel(animeInfo.titleEnglish)
                
                strongSelf.synopsisLabel.text = validateLabel(animeInfo.synopsis)
                
                strongSelf.anime = animeInfo
                strongSelf.genreCollectionView.reloadData()
                
                strongSelf.activityIndicator.stopAnimating()
            }
        }
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let currentAnime = anime else {
            return
        }
        
        PersonalAnimeDataManager.add(id: currentAnime.malID, image: self.animeImage.image,
                                     title: currentAnime.title, date: Date())
    }
    
}

extension AnimeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard anime != nil else {return 0}
        
        return anime!.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard anime != nil else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as! GenreCollectionViewCell
        
        cell.configure(with: anime!.genres[indexPath.row].name)
        
        return cell
    }
}
