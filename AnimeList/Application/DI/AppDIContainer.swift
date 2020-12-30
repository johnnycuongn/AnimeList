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
    func makeTopAnimesPageViewModel(flow: TopAnimesPageFlowCoordinator) -> TopAnimesPageViewModel
    func makeRandomPageViewModel() -> RandomPageViewModel
}

class AppDIContainer: BaseDI {
    
    let networkManager: Networking = NetworkManager()
    let apiPath: APIPath = JikanAnimeAPI()
    
    // MARK: - Top
    func makeTopAnimesReadUseCase() -> TopAnimesReadUseCase {
        return DefaultTopAnimesReadUseCase(animeWebService: makeTopAnimeRepository() )
    }
    
    func makeTopViewController(flow: TopAnimesPageFlowCoordinator) -> TopViewController {
        return TopViewController.create(with: makeTopAnimesPageViewModel(flow: flow))
    }
    
    func makeTopAnimesPageViewModel(flow: TopAnimesPageFlowCoordinator) -> TopAnimesPageViewModel {
        return DefaultTopAnimesPageViewModel(animeUseCase: makeTopAnimesReadUseCase(), flow: flow)
    }

    // MARK: - AnimeDetails && Random
    
    func makeSaveOfflineUseCase() -> SaveOfflineUseCase {
        return DefaultSaveOfflineUseCase(animeStorage: makePersonalAnimeStorageCreateDelete())
    }
    
    func makeAnimeDetailsUseCase() -> AnimeDetailsUseCase {
        return DefaultAnimeDetailsUseCase(animeWebService: makeAnimeDetailsRepository())
    }
    
    func makeRandomPageViewModel() -> RandomPageViewModel {
        return DefaultRandomPageViewModel(animeUseCase: makeAnimeDetailsUseCase(), saveUseCase: makeSaveOfflineUseCase())
    }
    
    // MARK: - Search
    
    func makeSearchAnimesViewController(flow: SearchAnimesPageFlowCoordinatoor) -> SeachAnimesViewController {
        return SeachAnimesViewController.create(with: makeSearchAnimesPageViewModel(flow: flow))
    }
    
    func makeSearchAnimesPageViewModel(flow: SearchAnimesPageFlowCoordinatoor) -> SearchAnimesPageViewModel {
        return DefaultSearchAnimesPageViewModel(searchUseCase: makeSearchAnimesUseCase(), flow: flow)
    }
    
    func makeSearchAnimesUseCase() -> SearchAnimesUseCase {
        return DefaultSearchAnimesUseCase(animeWebService: makeSearchAnimeRepository())
    }
    
    // MARK: - Repository

    func makeTopAnimeRepository() -> TopAnimeRepository {
        return DefaultAnimeFetchRepository(networkManager: self.networkManager, apiPath: self.apiPath)
    }
    
    func makeAnimeDetailsRepository() -> AnimeDetailsRepository {
        return DefaultAnimeFetchRepository(networkManager: self.networkManager, apiPath: self.apiPath)
    }
    
    func makeSearchAnimeRepository() -> SearchAnimeRepository {
        return DefaultAnimeFetchRepository(networkManager: self.networkManager, apiPath: self.apiPath)
    }
    
    // MARK: - Storage
    
    func makePersonalAnimeStorageCreateDelete() -> PersonalAnimeStorageCreateDelete {
        return PersonalAnimeCoreDataStorage(coreDataStorage: CoreDataStorage.shared)
    }
    
    func makePersonalAnimeStorageRead() -> PersonalAnimeStorageRead {
        return PersonalAnimeCoreDataStorage(coreDataStorage: CoreDataStorage.shared)
    }
    
}
