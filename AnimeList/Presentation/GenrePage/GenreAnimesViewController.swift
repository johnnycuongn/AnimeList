//
//  GenreViewController.swift
//  AnimeList
//
//  Created by Johnny on 23/10/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class GenreAnimesViewController: UIViewController {
    
    private var id: Int = 0
    
    public func initialize(id: Int) {
        self.viewModel = DefaultGenreAnimesPageViewModel(id: id)
        self.id = id
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var genreAnimeCollectionView: UICollectionView!
    
    var viewModel: GenreAnimesPageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genreAnimeCollectionView.dataSource = self
        genreAnimeCollectionView.delegate = self
        
        genreAnimeCollectionView.register(UINib(nibName: AnimeThumbnailCell.identifier, bundle: nil), forCellWithReuseIdentifier:  AnimeThumbnailCell.identifier)
        
//        loadAnime()
        bind(to: self.viewModel)
        viewModel.loadAnimes(page: 1)
    }
    
    private func bind(to viewModel: GenreAnimesPageViewModel) {
        viewModel.loading.observe(on: self) { [weak self] in
            self?.updateLoading($0)
        }
        
        viewModel.animes.observe(on: self) { [weak self] _ in
            self?.genreAnimeCollectionView.reloadData()
        }
    }
    
    private func updateLoading(_ loadingStyle: LoadingStyle?) {
        switch loadingStyle {
        case .fullscreen:
            self.activityIndicator.startAnimating()
        case .none:
            self.activityIndicator.stopAnimating()
        }
    }
    
    

    @IBAction func closeButtonTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension GenreAnimesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.animes.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimeThumbnailCell.identifier, for: indexPath) as! AnimeThumbnailCell
        
        let anime = viewModel.animes.value[indexPath.row]
        
        cell.config(with: anime)
        
        return cell
    }
}

extension GenreAnimesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Genre Anime - \(viewModel.animes.value[indexPath.row].title)")
        weak var animeVC = AnimeDetailsViewController.initialize(with: viewModel.animes.value[indexPath.row].malID)
        guard animeVC != nil else { return }
        self.present(animeVC!, animated: true, completion: nil)
    }
}

extension GenreAnimesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return AnimeThumbnailCell.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }
}
