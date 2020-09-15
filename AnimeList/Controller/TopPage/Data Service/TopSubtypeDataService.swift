//
//  TopSubtypeDataService.swift
//  AnimeList
//
//  Created by Johnny on 14/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

protocol SubtypeDataServiceDelegate {
    func didSelect(subtype: AnimeTopSubtype)
}

class TopSubtypeDataService: NSObject, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var delegate: SubtypeDataServiceDelegate!
    
    let subtypes: [AnimeTopSubtype] = [.bydefault, .bypopularity, .favorite, .airing, .tv, .movie, .ova, .upcoming]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subtypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopSubtypeCell.identifier, for: indexPath) as! TopSubtypeCell
        
        cell.config(with: subtypes[indexPath.row])
        
        return cell
    }
    
}

extension TopSubtypeDataService: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4,
                      height: collectionView.frame.height-10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 50)
    }
    
}


extension TopSubtypeDataService: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Subtype did select: \(subtypes[indexPath.row])")
        delegate.didSelect(subtype: subtypes[indexPath.row])
    }
    
}
