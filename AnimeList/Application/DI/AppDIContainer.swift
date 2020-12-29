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
    func makeTopAnimesPageViewModel(actions: TopAnimesPageViewModelAction?) -> TopAnimesPageViewModel
    func makeRandomPageViewModel() -> RandomPageViewModel
}

class AppDIContainer: BaseDI {
    
    let networkManager: Networking = NetworkManager()
    let apiPath: APIPath = JikanAnimeAPI()
    
    // MARK: - Top
    func makeTopAnimesReadUseCase() -> TopAnimesReadUseCase {
        return DefaultTopAnimesReadUseCase(animeWebService: makeTopAnimeRepository() )
    }
    
    func makeTopViewController(actions: TopAnimesPageViewModelAction? = nil) -> TopViewController {
        return TopViewController.create(with: makeTopAnimesPageViewModel(actions: actions))
    }
    
    func makeTopAnimesPageViewModel(actions: TopAnimesPageViewModelAction? = nil) -> TopAnimesPageViewModel {
        return DefaultTopAnimesPageViewModel(animeUseCase: makeTopAnimesReadUseCase(), actions: actions)
    }

    // MARK: - AnimeDetails && Random
    
    func makeSaveOfflineUseCase() -> SaveOfflineUseCase {
        return DefaultSaveOfflineUseCase(animeStorage: makePersonalAnimeStorageCreateDelete())
    }
    
    func makeAnimeDetailsUseCase() -> AnimeDetailsUseCase {
        return DefaultAnimeDetailsUseCase(animeWebService: makeAnimeDetailsRepository())
    }
    
    // MARK: Random
    
    func makeRandomPageViewModel() -> RandomPageViewModel {
        return DefaultRandomPageViewModel(animeUseCase: makeAnimeDetailsUseCase(), saveUseCase: makeSaveOfflineUseCase())
    }
    
    // MARK: - Repository

    func makeTopAnimeRepository() -> TopAnimeRepository {
        return DefaultAnimeFetchRepository(networkManager: self.networkManager, apiPath: self.apiPath)
    }
    
    func makeAnimeDetailsRepository() -> AnimeDetailsRepository {
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

extension AppDIContainer {
    func makeTopAnimesPageFlowCoordinatoor(navigationController: UINavigationController) -> TopAnimesPageFlowCoordinator {
        return DefaultTopAnimesPageFlowCoordinator(navigationController: navigationController)
    }
}
