//
//  AnimeViewController.swift
//  AnimeList
//
//  Created by Johnny on 24/10/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

protocol AnimeDelegate {
    func animeDidSelect(with id: Int)
}

class AnimeViewController: UIViewController, AnimeDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func animeDidSelect(with id: Int) {
        print("Anime Delefate Did Select - id: \(id)")
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
