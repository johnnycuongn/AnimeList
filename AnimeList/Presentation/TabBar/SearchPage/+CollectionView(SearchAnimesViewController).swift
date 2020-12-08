//
//  +CollectionView(SearchAnimesViewController).swift
//  AnimeList
//
//  Created by Johnny on 1/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit
// MARK: - FLOW LAYOUT
extension SeachAnimesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.width - 20, height: self.collectionView.frame.height / 4)
 
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

    }
}


// MARK: - DELEGATE & DATA SOURCES
extension SeachAnimesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.animes.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        
//        cell.configure(with: self.viewModel.animes.value[indexPath.row])
        
        cell.fill(with: self.viewModel.animes.value[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("isSearching Did Select: \(self.viewModel.animes.value[indexPath.row].title)")
        weak var animeVC = AnimeDetailsViewController.initialize(with: self.viewModel.animes.value[indexPath.row].id)
        guard animeVC != nil else { return }
        self.present(animeVC!, animated: true, completion: nil)
        
    }
}


