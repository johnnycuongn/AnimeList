//
//  ErrorViewController.swift
//  AnimeList
//
//  Created by Johnny on 28/7/21.
//  Copyright © 2021 Johnny. All rights reserved.
//

import Foundation
import UIKit

protocol ErrorViewDelegate {
    func reload()
}

class ErrorView: UIView {
    
    var delegate: ErrorViewDelegate?
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var reloadBtn: UIButton!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        errorLabel.tintColor = .white

        reloadBtn.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        reloadBtn.layer.cornerRadius = 10
        reloadBtn.layer.shadowOffset = .init(width: 1, height: 2)
        reloadBtn.layer.shadowColor = .some(UIColor.black.cgColor)
        reloadBtn.layer.shadowOpacity = 0.5
    }

    @IBAction func reloadBtnTapped(_ sender: UIButton) {
        delegate?.reload()
    }

    /** Loads instance from nib with the same name. */
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
}
