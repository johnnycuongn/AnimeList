//
//  AppDIContainer.swift
//  AnimeList
//
//  Created by Johnny on 14/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import Foundation
import UIKit

protocol BaseDI {
    func makeTopAnimesPageViewModel(coordinator: Coordinator) -> TopAnimesPageViewModel
    func makeRandomPageViewModel() -> RandomPageViewModel
}

class AppDIContainer: BaseDI {
    
    let networkManager: Networking
    let apiPath: APIPath
    var appCoordinator: Coordinator?
    
    
    init(networkManager: Networking, apiPath: APIPath) {
        self.networkManager = networkManager
        self.apiPath = apiPath
    }
    
    func startAppCoordinator(navigation: UINavigationController) {
        self.appCoordinator = AppFlowCoordinatoor(navigationController: navigation)
        appCoordinator?.start()
    }

    
    // MARK: - Top

//    func makeTopViewController() -> TopViewController {
//        guard let coordinator = appCoordinator else {
//            fatalError("Cant find coordinator")
//        }
//        return TopViewController.create(with: makeTopAnimesPageViewModel(coordinator: coordinator))
//    }

    func makeTopAnimesPageViewModel(coordinator: Coordinator) -> TopAnimesPageViewModel {
        return DefaultTopAnimesPageViewModel(animeUseCase: makeTopAnimesReadUseCase(), coordinator: coordinator)
    }
    
    func makeTopAnimesReadUseCase() -> TopAnimesReadUseCase {
        return DefaultTopAnimesReadUseCase(animeRepository: makeTopAnimeRepository() )
    }

    // MARK: - AnimeDetails && Random
    
    func makeAnimeDetailsViewController(id: Int) -> AnimeDetailsViewController {
        guard let coordinator = appCoordinator else {
            fatalError("Cant find coordinator")
        }
        return AnimeDetailsViewController.create(with: makeAnimeDetailsPageViewModel(id: id, coordinator: coordinator))
    }
    
    func makeAnimeDetailsPageViewModel(id: Int, coordinator: Coordinator) -> AnimeDetailsPageViewModel {
        return DefaultAnimeDetailsPageViewModel(animeID: id, animeUseCase:  makeAnimeDetailsUseCase(), saveUseCase: makeSaveOfflineUseCase(), coordinator: coordinator)
    }

    func makeRandomPageViewModel() -> RandomPageViewModel {
        return DefaultRandomPageViewModel(animeUseCase: makeAnimeDetailsUseCase(), saveUseCase: makeSaveOfflineUseCase())
    }
    
    private func makeAnimeDetailsUseCase() -> AnimeDetailsUseCase {
        return DefaultAnimeDetailsUseCase(animeRepository: makeAnimeDetailsRepository())
    }
    
    func makeSaveOfflineUseCase() -> SaveOfflineUseCase {
        return DefaultSaveOfflineUseCase(animeStorage: makePersonalAnimeStorageCreateDelete())
    }
    
    // MARK: - Search
    
    func makeSearchAnimesViewController() -> SeachAnimesViewController {
        guard let coordinator = appCoordinator else {
            fatalError("Cant find coordinator")
        }
        
        return SeachAnimesViewController.create(with: makeSearchAnimesPageViewModel(coordinator: coordinator))
    }
    
    func makeSearchAnimesPageViewModel(coordinator: Coordinator) -> SearchAnimesPageViewModel {
        return DefaultSearchAnimesPageViewModel(searchUseCase: makeSearchAnimesUseCase(), coordinator: coordinator)
    }
    
    private func makeSearchAnimesUseCase() -> SearchAnimesUseCase {
        return DefaultSearchAnimesUseCase(animeRepository: makeSearchAnimeRepository())
    }
    
    // MARK: - Discover
    func makeDiscoverPageViewModel(coordinator: Coordinator) -> DiscoverPageViewModel {
        return DefaultDiscoverPageViewModel(coordinator: coordinator)
    }
    
    // MARK: - Genre
    
    func makeGenreAnimesViewController(genreID: Int) -> GenreAnimesViewController {
        guard let coordinator = appCoordinator else {
            fatalError("Cant find coorditor")
        }
        
        return GenreAnimesViewController.create(viewModel: makeGenreAnimesPageViewModel(genreID: genreID, coordinator: coordinator))
    }
    
    func makeGenreAnimesPageViewModel(genreID: Int, coordinator: Coordinator) -> GenreAnimesPageViewModel {
        return DefaultGenreAnimesPageViewModel(id: genreID, animeUseCase: makeGenreAnimesUseCase(), coordinator: coordinator)
    }
    
    private func makeGenreAnimesUseCase() -> GenreAnimesUseCase {
        return DefaultGenreAnimesUseCase(animeRepository: makeGenreAnimeRepository())
    }
    
    // MARK: - Repository

    private func makeTopAnimeRepository() -> TopAnimeRepository {
        return DefaultAnimeFetchRepository(networkManager: self.networkManager, apiPath: self.apiPath)
    }
    
    private func makeAnimeDetailsRepository() -> AnimeDetailsRepository {
        return DefaultAnimeFetchRepository(networkManager: self.networkManager, apiPath: self.apiPath)
    }
    
    private func makeSearchAnimeRepository() -> SearchAnimeRepository {
        return DefaultAnimeFetchRepository(networkManager: self.networkManager, apiPath: self.apiPath)
    }
    
    private func makeGenreAnimeRepository() -> GenreAnimeRepository {
        return DefaultAnimeFetchRepository(networkManager: self.networkManager, apiPath: self.apiPath)
    }
    
    // MARK: - Storage
    
    private func makePersonalAnimeStorageCreateDelete() -> PersonalAnimeStorageCreateDelete {
        return PersonalAnimeCoreDataStorage(coreDataStorage: CoreDataStorage.shared)
    }
    
    private func makePersonalAnimeStorageRead() -> PersonalAnimeStorageRead {
        return PersonalAnimeCoreDataStorage(coreDataStorage: CoreDataStorage.shared)
    }
    
}
