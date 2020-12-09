//
//  +CollectionViewDelegateFlowLayout(SearchPageVC).swift
//  AnimeList
//
//  Created by Johnny on 16/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

extension DiscoverPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: self.pageCollectionView.frame.width/2-40, height: self.pageCollectionView.frame.height / 3)
        }
        
        return CGSize(width: self.pageCollectionView.frame.width/3 - 16, height: self.pageCollectionView.frame.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 15, left: 30, bottom: 15, right: 30)
        }
        
        return UIEdgeInsets(top: 15, left: 8, bottom: 15, right: 8)
    }
}

extension DiscoverPageViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        else {
            return self.genres.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as! GenreCell
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.config(for: "SEASON")
            } else {
                cell.config(for: "RANDOM")
            }
        }
        else {
            cell.config(with: genres[indexPath.row])
        }
        
        return cell
    }
}

extension DiscoverPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                print("Navigate to Season")
            } else {
                print("Navigate to Random")
            }
        }
        
        else {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let genreID = genres[indexPath.row].rawValue
            print("Genre Did Select: \(genres[indexPath.row])")
            
            let genreVC = storyBoard.instantiateViewController(withIdentifier: "GenreViewController") as! GenreAnimesViewController
            genreVC.initialize(id: genreID)
            genreVC.title = String(describing: genres[indexPath.row])
            
            self.navigationController?.pushViewController(genreVC, animated: true)
            
        }
        
    }
}
