//
//  GenreViewController.swift
//  AnimeList
//
//  Created by Johnny on 23/10/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {
    
    private var id: Int = 0
    
    public func initialize(id: Int) {
        self.id = id
    }
    
    @IBOutlet weak var genreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Genre Page DID LOAD with - \(id)")
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
