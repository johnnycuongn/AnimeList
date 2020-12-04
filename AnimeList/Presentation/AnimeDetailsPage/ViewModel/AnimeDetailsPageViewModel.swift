//
//  AnimeDetailsViewModel.swift
//  AnimeList
//
//  Created by Johnny on 29/11/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

// MARK: - VIEW MODEL

protocol AnimeDetailsPageViewModel {
    var id: Int { get set }
    
    var animeDetailsViewModel: Observable<AnimeDetailsViewModel> { get }
    var isAnimeSaved: Observable<Bool> { get }
    var loadingStyle: Observable<LoadingStyle?> { get }
    
    func loadAnime(id: Int)
    func updateSave()
}

// MARK: - DEFAULT VIEW MODEL

class DefaultAnimeDetailsPageViewModel: AnimeDetailsPageViewModel {
    
    var id: Int = 0
    private var posterImagePath: URL?
    
    var animeDetailsViewModel: Observable<AnimeDetailsViewModel> = Observable(DefaultAnimeDetailsViewModel())
    var isAnimeSaved: Observable<Bool> = Observable(false)
    
    var loadingStyle: Observable<LoadingStyle?> = Observable(.none)
    
    let animeWS: AnimeDetailsWebService = DefaultAnimeWebService()
    let animeStorage: PersonalAnimeStorageCreateDelete = PersonalAnimeCoreDataStorage()
    
    init(animeID: Int,
         animeWebService: AnimeDetailsWebService = DefaultAnimeWebService(),
         animeStorage: PersonalAnimeStorageCreateDelete = PersonalAnimeCoreDataStorage()) {
        self.id = animeID
    }
    
    func loadAnime(id: Int) {
        loadingStyle.value = .fullscreen
        
        
        animeWS.fetchAnimeDetails(id: self.id) {
        
        [weak self] (result) in
            print("AnimeDetailsPageViewModel: Anime Did Fetch - \(id)")
            switch result {
            case .success(let animeInfo):
            self?.posterImagePath = animeInfo.imageURL
            self?.loadImage()

            self?.animeDetailsViewModel.value.score = validateLabel(animeInfo.score)
            self?.animeDetailsViewModel.value.rank = validateLabel(animeInfo.rank)
            self?.animeDetailsViewModel.value.popularity = validateLabel(animeInfo.popularity)
            self?.animeDetailsViewModel.value.members = validateLabel(animeInfo.members)
            self?.animeDetailsViewModel.value.favorites = validateLabel(animeInfo.favorites)

            // FIXME: Should have multiple studios
            self?.animeDetailsViewModel.value.studio = validateLabel(animeInfo.studios[0].name)

            self?.animeDetailsViewModel.value.type = validateLabel(animeInfo.type.rawValue)
            self?.animeDetailsViewModel.value.episodes = validateLabel(animeInfo.episodes)

            self?.animeDetailsViewModel.value.premiered = validateLabel(animeInfo.premieredDate)
            self?.animeDetailsViewModel.value.status = validateLabel(animeInfo.status)

            self?.animeDetailsViewModel.value.rating = validateLabel(animeInfo.rating)

            self?.animeDetailsViewModel.value.title = validateLabel(animeInfo.title)
            self?.animeDetailsViewModel.value.engTitle = validateLabel(animeInfo.titleEnglish, return: .none)

            self?.animeDetailsViewModel.value.synopsis = validateLabel(animeInfo.synopsis)

            self?.animeDetailsViewModel.value.genres = animeInfo.genres
            
        self?.loadingStyle.value = .none
            case.failure(let error):
                print("Error: \(error)")
            }
        }
        
        loadSave(id: self.id)
    }
    
    private func loadSave(id: Int) {
        animeStorage.isIDExist(id) {
        
        [weak self] isExisted in
            
            if isExisted {
                self?.isAnimeSaved.value = true
            } else {
                self?.isAnimeSaved.value = false
            }

        }
    }
    
    func loadImage() {
        guard let animeImagePath = self.posterImagePath else { return }
        
        URLSession(configuration: .ephemeral).dataTask(with: animeImagePath) {
        [weak self] (data, response, error) in
            
            guard let data = data else {return}
        
            self?.animeDetailsViewModel.value.posterImageData.value = data

        }.resume()
    }
    
    func updateSave() {
        // If not saved, User want to add to DBs
        if isAnimeSaved.value == false {
            if animeDetailsViewModel.value.posterImageData.value == nil  {
                animeStorage.add(id: self.id,
                                 imageData: nil,
                                         title: animeDetailsViewModel.value.title,
                                         date: Date())
            }
            else {
                animeStorage.add(id: self.id,
                                 imageData:  animeDetailsViewModel.value.posterImageData.value!,
                                         title: animeDetailsViewModel.value.title,
                                         date: Date())
            }
            isAnimeSaved.value = true
            print("Viewmdel: Anime is saved!!!")
        }
        else {
            animeStorage.remove(id: self.id) {
                self.isAnimeSaved.value = false
            }
        }
    }
    
    
}
