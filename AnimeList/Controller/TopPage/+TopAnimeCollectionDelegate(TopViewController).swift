//
//  TopAnimeCollectionDelegate(TopViewController).swift
//  AnimeList
//
//  Created by Johnny on 14/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

extension TopViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Top Anime Select: \(topAnimes[indexPath.row].malID)")
    }
}
