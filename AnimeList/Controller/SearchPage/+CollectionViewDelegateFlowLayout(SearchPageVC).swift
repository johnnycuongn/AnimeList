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
        if PageState.isSearching {
            return CGSize(width: self.pageCollectionView.frame.width - 20, height: self.pageCollectionView.frame.height / 4)
        }

        return CGSize(width: self.pageCollectionView.frame.width/3 - 16, height: self.pageCollectionView.frame.height / 4)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if PageState.isSearching {
            return 10
        }
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if PageState.isSearching {
            return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
        return UIEdgeInsets(top: 15, left: 8, bottom: 15, right: 8)
    }
}
