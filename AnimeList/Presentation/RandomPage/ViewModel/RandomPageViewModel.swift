//
//  RandomPageViewModel.swift
//  AnimeList
//
//  Created by Johnny on 2/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

protocol RandomAnimeViewModel {
    var animeImageData: Observable<Data?> { get }
    
    var title: String { get set }
    var synopsis: String { get set }
    
    var rank: String { get set }
    var popularity: String { get set }
    
    var score: String { get set }
    var members: String { get set }
    
    var studios: String { get set }
    var type: String { get set }
    var episodes: String { get set }
    
    var genres: [GenreDisplayDTO] { get set }
}

class DefaultRandomAnimeViewModel: RandomAnimeViewModel {
    var animeImageData: Observable<Data?>
    
    var title: String
    
    var synopsis: String
    
    var rank: String
    
    var popularity: String
    
    var score: String
    
    var members: String
    
    var studios: String

    var type: String
    
    var episodes: String
    
    var genres: [GenreDisplayDTO]
    
    init(animeImageData: Observable<Data?> = Observable(.none), title: String, synopsis: String, rank: String, popularity: String, score: String, members: String, studios: String, type: String, episodes: String, genres: [GenreDisplayDTO]) {
        self.animeImageData = animeImageData
        self.title = title
        self.synopsis = synopsis
        self.rank = rank
        self.popularity = popularity
        self.score = score
        self.members = members
        self.studios = studios
        self.type = type
        self.episodes = episodes
        self.genres = genres
    }
}

protocol RandomPageViewModel {
    var id: Int { get }
    var animeViewModel: Observable<RandomAnimeViewModel> { get }
    
    var isAnimeSaved: Observable<Bool> { get }
    var loadingStyle: Observable<LoadingStyle?> { get }
    
    func loadAnime()
    func updateSave()
}

class DefaultRandomPageViewModel: RandomPageViewModel {
    
    var id: Int = 0
    
    var animeViewModel: Observable<RandomAnimeViewModel> = Observable(DefaultRandomAnimeViewModel(title: "", synopsis: "", rank: "", popularity: "", score: "", members: "", studios: "", type: "", episodes: "", genres: []))
    
    private var posterImagePath: URL?
    var isAnimeSaved: Observable<Bool> = Observable(false)
    
    var loadingStyle: Observable<LoadingStyle?> = Observable(.none)
    
    private var animeWS: AnimeDetailsWebService
    
    init(animeWebService: AnimeDetailsWebService = DefaultAnimeWebService()) {
        self.animeWS = animeWebService
    }
    
    func loadAnime() {
        let startTime = NSDate()
        
        RecommendService.shared.recommendID { (id) in
            self.loadingStyle.value = .fullscreen
    
            self.animeWS.fetchAnimeDetails(id: id) { [weak self] (result) in
                switch result {
                case .success(let animeInfo):
                guard let strongSelf = self else { return }
                    
//                    self?.animeViewModel.value = DefaultRandomAnimeViewModel(title: animeInfo.title,
//                                                                 synopsis: validateLabel(animeInfo.synopsis, return: .none), rank: validateLabel(animeInfo.rank), popularity: validateLabel(animeInfo.popularity), score: validateLabel(animeInfo.score), members: validateLabel( animeInfo.members), studios: validateLabel(animeInfo.studios[0].name), type: validateLabel(animeInfo.type.rawValue), episodes: validateLabel(animeInfo.episodes), genres: animeInfo.genres)
                    self?.posterImagePath = animeInfo.imageURL
                    self?.loadImage()
                    strongSelf.animeViewModel.value.title = animeInfo.title
                    strongSelf.animeViewModel.value.synopsis = validateLabel(animeInfo.synopsis, return: .none)

                    strongSelf.animeViewModel.value.rank = validateLabel(animeInfo.rank)
                    strongSelf.animeViewModel.value.popularity = validateLabel(animeInfo.popularity)

                    strongSelf.animeViewModel.value.score = validateLabel(animeInfo.score)
                    strongSelf.animeViewModel.value.members = validateLabel( animeInfo.members)

                    strongSelf.animeViewModel.value.studios = validateLabel(animeInfo.studios[0].name)

                    strongSelf.animeViewModel.value.type = validateLabel(animeInfo.type.rawValue)
                    strongSelf.animeViewModel.value.episodes = validateLabel(animeInfo.episodes)

                    strongSelf.animeViewModel.value.genres = animeInfo.genres
                    
                let endTime = NSDate()
                print("Random: Fetch && Display Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
            

                case .failure(let error):
                    print("Error: \(error)")
                }
                
                self?.loadingStyle.value = .none
            }
        }
        self.isIDExist(self.id)
        
        
    }
    
    func updateSave() {
        // If not saved, User want to add to DBs
        if isAnimeSaved.value == false {
            if animeViewModel.value.animeImageData.value == nil  {
            PersonalAnimeDataManager.add(id: self.id,
                                         image: nil,
                                         title: animeViewModel.value.title,
                                         date: Date())
            }
            else {
            PersonalAnimeDataManager.add(id: self.id,
                                         image: UIImage(data: animeViewModel.value.animeImageData.value!),
                                         title: animeViewModel.value.title,
                                         date: Date())
            }
            isAnimeSaved.value = true
        }
        else {
            PersonalAnimeDataManager.remove(id: self.id)
            isAnimeSaved.value = false
        }
    }
        
    func loadImage() {
        guard let animeImagePath = self.posterImagePath else { return }
        
        URLSession(configuration: .ephemeral).dataTask(with: animeImagePath) {
            [weak self] (data, response, error) in
            
            guard let data = data else {return}
            print("ViewModelLoadImage: \(data)")
            self?.animeViewModel.value.animeImageData.value = data
            
        }.resume()
    }
    
    private func isIDExist(_ id: Int) {
        PersonalAnimeDataManager.isIDExist(id) {[weak self] isExisted in
            if isExisted {
                self?.isAnimeSaved.value = true
            } else {
                self?.isAnimeSaved.value = false
            }
        }
    }
    
    
}
