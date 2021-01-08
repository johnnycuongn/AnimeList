//
//  TopAnimesPageViewModelTest.swift
//  AnimeListTests
//
//  Created by Johnny on 4/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import XCTest
@testable import AnimeList


class TopAnimesPageViewModelTest: XCTestCase {
    
    var sut: TopAnimesPageViewModel!
    
    var topAnimes: [TopAnimeMain.TopAnime] = {
        let anime1 = TopAnimeMain.TopAnime(rank: 1, malID: 1, imageURL: nil, title: "anime1", type: .movie, episodes: 1, members: 1, score: 1)
            
        
            return [anime1, anime1, anime1, anime1, anime1, anime1, anime1, anime1, anime1]
    }()
    
    var topAnimesSecondPage: [TopAnimeMain.TopAnime] = {
        let anime2 = TopAnimeMain.TopAnime(rank: 2, malID: 2, imageURL: nil, title: "anime1", type: .movie, episodes: 2, members: 2, score: 2)
            
        
            return [anime2, anime2, anime2, anime2, anime2, anime2, anime2, anime2, anime2]
    }()
    
    private enum TopAnimesUseCaseError: Error {
        case someError
    }
    
    class TopAnimesUseCaseMock: TopAnimesReadUseCase {
        
        var expectation: XCTestExpectation?
        
        var error: Error?
        var topAnimes: [TopAnimeMain.TopAnime] = []
        
        init(expectation: XCTestExpectation?, fetchedTopAnimes: [TopAnimeMain.TopAnime], error: Error?) {
            self.expectation = expectation
            self.topAnimes = fetchedTopAnimes
            self.error = error
        }
        
        func getAnimes(page: Int, subtype: AnimeTopSubtype, completion: @escaping (Result<[TopAnimeMain.TopAnime], Error>) -> Void) {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(topAnimes))
            }
            expectation?.fulfill()
        }
    }
    
    class TopAnimesPageFlowCoorMock: TopAnimesPageFlowCoordinator {
        
        var isShownAnimeDetails = false
        
        func showAnimeDetails(id: Int) {
            isShownAnimeDetails = true
        }
    }
    
    func test_whenGetAnimesFromUseCase_thenLoadAnimesWithoutError() {
        
        // given
        let topAnimesUseCase = TopAnimesUseCaseMock(
            expectation: self.expectation(description: "Successfully load animes from Use Case"),
            fetchedTopAnimes: topAnimes,
            error: nil)
        
        let topAnimesFlow = TopAnimesPageFlowCoorMock()
        
        sut = DefaultTopAnimesPageViewModel(animeUseCase: topAnimesUseCase, flow: topAnimesFlow)
        
        // when
        sut.loadAnimes(page: 1, subtype: .movie)
        
        // then
        waitForExpectations(timeout: 4, handler: nil)
        XCTAssertTrue(!sut.topAnimes.value.isEmpty)
        XCTAssertNil(sut.error.value)
        
    }
    
    func test_whenSubtypeIsSelected_thenViewModelCurrentSubtypeUpdate() {
        // given
        let topAnimesUseCase = TopAnimesUseCaseMock(
            expectation: self.expectation(description: "Successfully load animes from Use Case"),
            fetchedTopAnimes: topAnimes,
            error: nil)
        
        let topAnimesFlow = TopAnimesPageFlowCoorMock()
        
        sut = DefaultTopAnimesPageViewModel(animeUseCase: topAnimesUseCase, flow: topAnimesFlow)
        
        // when
        sut.didSelect(subtype: .airing)
        
        // then
        waitForExpectations(timeout: 4, handler: nil)
        XCTAssertEqual(sut.currentSubtype, .airing)
    }
    
    func test_whenErrorIsInvoked_thenViewModelErrorUpdate() {
        // given
        let topAnimesUseCase = TopAnimesUseCaseMock(
            expectation: self.expectation(description: "Failed to load animes from Use Case"),
            fetchedTopAnimes: [],
            error: TopAnimesUseCaseError.someError)
        
        let topAnimesFlow = TopAnimesPageFlowCoorMock()
        
        sut =  DefaultTopAnimesPageViewModel(animeUseCase: topAnimesUseCase, flow: topAnimesFlow)
        // when
        sut.loadAnimes(page: 1, subtype: .bydefault)
        
        // then
        waitForExpectations(timeout: 4, handler: nil)
        XCTAssertNotNil(sut.error)
    }
    


}
