//
//  RandomViewController.swift
//  AnimeList
//
//  Created by Johnny on 3/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController, UIScrollViewDelegate {
    
    static func create(with viewModel: RandomPageViewModel) -> RandomViewController {
        let storyboard = UIStoryboard.main
        guard let vc = storyboard.instantiateViewController(identifier: String(describing: self)) as? RandomViewController else {
            fatalError("Can't instantiate TopVC")
        }
        
        vc.viewModel = viewModel
        
        return vc
    }
    
    //MARK: - Outlets
    @IBOutlet weak var randomAnimeView: UIView!
    @IBOutlet weak var descriptionView: UIVisualEffectView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var visualEffectAnimeView: UIVisualEffectView!
    @IBOutlet weak var descriptionScrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIVisualEffectView!
    
    @IBOutlet weak var animeImageView: UIImageView!
    
    @IBOutlet weak var animeTitle: UILabel!
    @IBOutlet weak var animeSynopsis: UILabel!
    @IBOutlet weak var animeRank: UILabel!
    @IBOutlet weak var animePopularity: UILabel!
    @IBOutlet weak var animeScore: UILabel!
    @IBOutlet weak var animeMembers: UILabel!
    @IBOutlet weak var animeStudio: UILabel!
    @IBOutlet weak var animeTypeEpisode: UILabel!
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var genreCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - View Controller's Variables
    var viewModel: RandomPageViewModel!
    
    func loadController(with viewModel: RandomPageViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.color = .black
        activityIndicator.style = .medium
        
        descriptionScrollView.delegate = self
        
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        
        bind(to: self.viewModel)
        viewModel.loadAnime()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLayoutSubviews() {
        randomAnimeView.layer.cornerRadius = 7
        
        let height = genreCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        genreCollectionViewHeight.constant = height
        self.view.layoutIfNeeded()
        
        descriptionScrollView.contentInset.bottom = bottomView.frame.height
        configureGenreCLV()
        
        saveButton.layer.cornerRadius = 5
    }
    
    private func bind(to viewModel: RandomPageViewModel) {
        viewModel.isAnimeSaved.observe(on: self) { [weak self] in self?.updateSaveButton($0)}
        
        viewModel.loadingStyle.observe(on: self) { [weak self] in self?.updateLoading($0) }
        
        viewModel.animeViewModel.observe(on: self) { [unowned self] in
            animeTitle.text = $0.title
            animeSynopsis.text = $0.synopsis
            
            animeRank.text = "#\($0.rank)"
            animePopularity.text = "#\($0.popularity)"
            
            animeScore.text = $0.score
            animeMembers.text = $0.members
            
            animeStudio.text = $0.studios
            animeTypeEpisode.text = "\($0.type)(\($0.episodes))"
            
            self.genreCollectionView.reloadData()
        }
        
        viewModel.animeViewModel.value.animeImageData.observe(on: self) {
            [weak self] (imageData) in
            print("Anime Did Set")
            self?.animeImageView.image = imageData.flatMap(UIImage.init)
        }
    }
    
    private func updateLoading(_ loadingStyle: LoadingStyle?) {
        switch loadingStyle {
        case .fullscreen:
            self.activityIndicator.startAnimating()
            nextBtn.isHidden = true
            saveButton.isHidden = true
        case .none:
            self.activityIndicator.stopAnimating()
            nextBtn.isHidden = false
            saveButton.isHidden = false
        }
    }
    
    private func updateSaveButton(_ isAnimeSaved: Bool) {
        if isAnimeSaved == true {
            self.saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
        else {
            self.saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
    }
    
    // MARK: - Buttons Action
    @IBAction func nextBtnTapped(_ sender: Any) {
        viewModel.loadAnime()
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        viewModel.updateSave()
    }
    
}

extension RandomViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension RandomViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.animeViewModel.value.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreDisplayCollectionViewCell.identifier, for: indexPath) as! GenreDisplayCollectionViewCell
        
        cell.configure(with: viewModel.animeViewModel.value.genres[indexPath.row].name)
        
        return cell
    }
}

extension RandomViewController {
    private func configureGenreCLV() {
        descriptionScrollView.contentInset.top = randomAnimeView.bounds.height - bottomView.bounds.height - animeTitle.bounds.height - genreCollectionView.collectionViewLayout.collectionViewContentSize.height - 16 - 2
        descriptionScrollView.contentOffset = CGPoint(x: 0, y: -descriptionScrollView.contentInset.top)
    }
}
