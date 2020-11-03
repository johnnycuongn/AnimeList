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
    
    static func initialize(with id: Int) -> AnimeViewController? {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let animeVC = storyBoard.instantiateViewController(withIdentifier: "AnimeViewController") as? AnimeViewController else { return nil }
        animeVC.id = id
        animeVC.modalPresentationStyle = .overFullScreen
        
        return animeVC
    }
    
    private var id: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadAnime(id: self.id)
    }
    
    func loadAnime(id: Int) {
        AnimeInfoService.shared.fetchAnime(id: id) { (animeInfo) in
            print("Anime Fetched: \(animeInfo.title) - \(animeInfo.url)")
        }
    }
    
    func animeDidSelect(with id: Int) {
        self.id = id
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
