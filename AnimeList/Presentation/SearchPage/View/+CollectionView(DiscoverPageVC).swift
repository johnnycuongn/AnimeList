//
//  +CollectionViewDelegateFlowLayout(SearchPageVC).swift
//  AnimeList
//
//  Created by Johnny on 16/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

extension SearchPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.pageCollectionView.frame.width/3 - 16, height: self.pageCollectionView.frame.height / 4)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 15, left: 8, bottom: 15, right: 8)
    }
}

extension SearchPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.genres.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as! GenreCell
            
        cell.config(with: genres[indexPath.row])
            
        return cell

    }
}

extension SearchPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let genreID = genres[indexPath.row].rawValue
        print("Genre Did Select: \(genres[indexPath.row])")
        
        let genreVC = storyBoard.instantiateViewController(withIdentifier: "GenreViewController") as! GenreAnimesViewController
        genreVC.initialize(id: genreID)
        genreVC.title = String(describing: genres[indexPath.row])
        
        self.navigationController?.pushViewController(genreVC, animated: true)
        
        
    }
}
