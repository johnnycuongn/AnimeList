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
    
    let networkManager: Networking
    let apiPath: APIPath
    
    init(networkManager: Networking, apiPath: APIPath) {
        self.networkManager = networkManager
        self.apiPath = apiPath
    }
    
    // MARK: - Top

    func makeTopViewController(flow: TopAnimesPageFlowCoordinator) -> TopViewController {
        return TopViewController.create(with: makeTopAnimesPageViewModel(flow: flow))
    }
    
    func makeTopAnimesPageViewModel(flow: TopAnimesPageFlowCoordinator) -> TopAnimesPageViewModel {
        return DefaultTopAnimesPageViewModel(animeUseCase: makeTopAnimesReadUseCase(), flow: flow)
    }
    
    func makeTopAnimesReadUseCase() -> TopAnimesReadUseCase {
        return DefaultTopAnimesReadUseCase(animeWebService: makeTopAnimeRepository() )
    }

    // MARK: - AnimeDetails && Random

    func makeRandomPageViewModel() -> RandomPageViewModel {
        return DefaultRandomPageViewModel(animeUseCase: makeAnimeDetailsUseCase(), saveUseCase: makeSaveOfflineUseCase())
    }
    
    private func makeAnimeDetailsUseCase() -> AnimeDetailsUseCase {
        return DefaultAnimeDetailsUseCase(animeWebService: makeAnimeDetailsRepository())
    }
    
    func makeSaveOfflineUseCase() -> SaveOfflineUseCase {
        return DefaultSaveOfflineUseCase(animeStorage: makePersonalAnimeStorageCreateDelete())
    }
    
    // MARK: - Search
    
    func makeSearchAnimesViewController(flow: SearchAnimesPageFlowCoordinatoor) -> SeachAnimesViewController {
        return SeachAnimesViewController.create(with: makeSearchAnimesPageViewModel(flow: flow))
    }
    
    func makeSearchAnimesPageViewModel(flow: SearchAnimesPageFlowCoordinatoor) -> SearchAnimesPageViewModel {
        return DefaultSearchAnimesPageViewModel(searchUseCase: makeSearchAnimesUseCase(), flow: flow)
    }
    
    private func makeSearchAnimesUseCase() -> SearchAnimesUseCase {
        return DefaultSearchAnimesUseCase(animeWebService: makeSearchAnimeRepository())
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
    
    // MARK: - Storage
    
    private func makePersonalAnimeStorageCreateDelete() -> PersonalAnimeStorageCreateDelete {
        return PersonalAnimeCoreDataStorage(coreDataStorage: CoreDataStorage.shared)
    }
    
    private func makePersonalAnimeStorageRead() -> PersonalAnimeStorageRead {
        return PersonalAnimeCoreDataStorage(coreDataStorage: CoreDataStorage.shared)
    }
    
}
