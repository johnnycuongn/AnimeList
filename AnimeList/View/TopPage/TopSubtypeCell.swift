//
//  TopSubtypeCell.swift
//  AnimeList
//
//  Created by Johnny on 14/9/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class TopSubtypeCell: UICollectionViewCell {
    
    @IBOutlet weak var topSubtypeLabel: UILabel!
    
    static let identifier = String(describing: TopSubtypeCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5
        
        let selectedView = UIView(frame: bounds)
        selectedView.backgroundColor = AssetColor.darkBlue
        self.selectedBackgroundView = selectedView
        
        let clearView = UIView(frame: bounds)
        clearView.backgroundColor = .clear
        self.backgroundView = clearView
    }
    
    func config(with subtype: AnimeTopSubtype) {
        topSubtypeLabel.text = subtype.rawValue
    }
    
    
    
    
}
