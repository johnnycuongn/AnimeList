//
//  AnimeViewController.swift
//  AnimeList
//
//  Created by Johnny on 24/10/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class AnimeDetailsViewController: UIViewController {
    
    static func create(with viewModel: AnimeDetailsPageViewModel) -> AnimeDetailsViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let animeVC = storyBoard.instantiateViewController(withIdentifier: "AnimeDetailsViewController") as? AnimeDetailsViewController else { fatalError("Can't instantiate AnimeDetailsVC") }
        
        animeVC.viewModel = viewModel

        animeVC.modalPresentationStyle = .overFullScreen
        
        return animeVC
    }
    
    // MARK: - View Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backgroundAnimeImageView: UIImageView!
    @IBOutlet weak var animeImageView: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreLabelView: UIView!
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    
    @IBOutlet weak var studioLabel: UILabel!
    @IBOutlet weak var premieredLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var typeEpisodesLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
   
    @IBOutlet weak var animeTitleLabel: UILabel!
    @IBOutlet weak var animeEngTitleLabel: UILabel!
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Layout Constraints
    @IBOutlet weak var genreCollectionViewHeight: NSLayoutConstraint!
    
    // MARK: - View Controller's Variables
    
    var viewModel: AnimeDetailsPageViewModel!
    
    // MARK: - View Loading
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadAnime(id: viewModel.id)
        bind(to: self.viewModel)
        
        
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()    
        scoreLabelView.layer.cornerRadius = 7
        
        closeButton.layer.cornerRadius = 5
        saveButton.layer.cornerRadius = 5
        
//        let height =
//            genreCollectionView.collectionViewLayout.collectionViewContentSize.height
//
//        genreCollectionViewHeight.constant = height
//        self.genreCollectionView.layoutIfNeeded()
        
    }
    
    private func bind(to viewModel: AnimeDetailsPageViewModel) {
        viewModel.animeDetailsViewModel.value.posterImageData.observe(on: self) { [weak self] (imageData) in
            self?.animeImageView.image = imageData.flatMap(UIImage.init)
        }
        
        viewModel.isAnimeSaved.observe(on: self) { [weak self] in
            self?.updateSaveButton($0)
        }
        
        viewModel.loadingStyle.observe(on: self) { [weak self] in
            self?.updateLoading($0)
        }
        
        viewModel.animeDetailsViewModel.observe(on: self) { [unowned self] in
            self.scoreLabel.text = $0.score
            self.rankLabel.text = "#\($0.rank)"
            self.popularityLabel.text = "#\($0.popularity)"
            self.membersLabel.text = $0.members
            self.favoritesLabel.text = $0.favorites
            
            self.studioLabel.text = $0.studio
            
            self.typeEpisodesLabel.text = "\($0.type)(\($0.episodes))"
            
            self.premieredLabel.text = $0.premiered
            self.statusLabel.text = $0.status
            
            self.ratingLabel.text = $0.rating
            
            self.animeTitleLabel.text = $0.title
            self.animeEngTitleLabel.text = $0.engTitle
            self.synopsisLabel.text = $0.synopsis
            
            self.genreCollectionView.reloadData()
        }
    }
    
    private func updateSaveButton(_ isAnimeSaved: Bool) {
        DispatchQueue.main.async {
            if isAnimeSaved == true {
                self.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            }
            else {
                self.saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            }
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
    
    // MARK: - Button Action
    //------------------------
    @IBAction func closeButtonTapped(_ sender: Any) {
        viewModel.closePage()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        viewModel.updateSave()
    }
    
}

    // MARK: - Genre Collection View
extension AnimeDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return viewModel.animeDetailsViewModel.value.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreDisplayCollectionViewCell.identifier, for: indexPath) as! GenreDisplayCollectionViewCell
        

        cell.configure(with: viewModel.animeDetailsViewModel.value.genres[indexPath.row].name)
        
        return cell
    }
}
