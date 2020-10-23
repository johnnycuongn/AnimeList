//
//  GenreViewController.swift
//  AnimeList
//
//  Created by Johnny on 23/10/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {
    
    private var id: Int = 0
    
    @IBOutlet weak var genreAnimeCollectionView: UICollectionView!
    @IBOutlet weak var genreLabel: UILabel!
    
    private var animes: [AnimeDisplayInfo] = [] {
        didSet {
            DispatchQueue.main.async {
                self.genreAnimeCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genreAnimeCollectionView.dataSource = self
        genreAnimeCollectionView.delegate = self
        
        genreAnimeCollectionView.register(UINib(nibName: AnimeDisplayCell.identifier, bundle: nil), forCellWithReuseIdentifier:  AnimeDisplayCell.identifier)
        
        loadAnime()
    }
    
    func loadAnime(page: Int = 1) {
        print("Genre; \(id)")
        GenreAnimeService.shared.fetchGenre(id: self.id, page: page) { [weak self] (genreMain) in
            guard let strongSelf = self else { return }
            
            strongSelf.animes.append(contentsOf: genreMain.anime)
        }
    }
    
    public func initialize(id: Int) {
        self.id = id
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension GenreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.animes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimeDisplayCell.identifier, for: indexPath) as! AnimeDisplayCell
        
        let anime = animes[indexPath.row]
        
        cell.config(with: anime)
        
        return cell
    }
}

extension GenreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Genre Anime - \(animes[indexPath.row].title)")
    }
}

extension GenreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = genreAnimeCollectionView.frame.width / 2.2
        let cellHeight = genreAnimeCollectionView.frame.height / 2.8
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }
}
