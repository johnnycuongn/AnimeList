//
//  PersonalViewController.swift
//  AnimeList
//
//  Created by Johnny on 25/10/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController {

    @IBOutlet weak var animeCollectionView: UICollectionView!
    
    var animes: [PersonalAnime] {
        return PersonalAnimeDataManager.fetchFromDB()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animeCollectionView.delegate = self
        animeCollectionView.dataSource = self
        
        animeCollectionView.reloadData()
    }

}

extension PersonalViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width / 2.2
        let cellHeight = collectionView.frame.height / 2.8
        
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

extension PersonalViewController: PersonalAnimeActionDelegate {
    func complete(_ cell: PersonalAnimeCollectionViewCell) {
        let index = animeCollectionView.indexPath(for: cell)
        print("Did Complete Cell: \(index)")
    }
    
    func delete(_ cell: PersonalAnimeCollectionViewCell) {
        
        guard let indexPath = animeCollectionView.indexPath(for: cell) else { return }
        print("Did Remove Cell: \(index)")
        PersonalAnimeDataManager.remove(at: indexPath.row)
        
        animeCollectionView.reloadData()
    }
    
    
}

extension PersonalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonalAnimeCollectionViewCell.identifier, for: indexPath) as! PersonalAnimeCollectionViewCell
        
        cell.configure(with: animes[indexPath.row])
        cell.actionDelegate = self
        
        return cell
    }
    
    
}
