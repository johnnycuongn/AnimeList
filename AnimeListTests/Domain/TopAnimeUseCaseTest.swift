//
//  TopAnimeUseCase.swift
//  AnimeListTests
//
//  Created by Johnny on 11/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import XCTest
@testable import AnimeList

class TopAnimeUseCaseTest: XCTestCase {
    
    static var topAnimes: [TopAnimeMain.TopAnime] = {
        let anime1 = TopAnimeMain.TopAnime(rank: 1, malID: 1, imageURL: nil, title: "anime1", type: .movie, episodes: 1, members: 1, score: 1)
    
        let anime2 = TopAnimeMain.TopAnime(rank: 2, malID: 2, imageURL: nil, title: "anime2", type: .movie, episodes: 1, members: 1000, score: 8.9)
        
        return [anime1]
    }()
    
    
    var sut: TopAnimesReadUseCase!
    var topAnimeWebRepository: TopAnimeRepository!
    
    var testedSubtype: AnimeTopSubtype = .movie

    /// Mock Repository for TopAnimeRepostiory
    class TopAnimeWebRepositoryMock: TopAnimeRepository {
        
        var result: Result<[TopAnimeMain.TopAnime], Error>
        init(result: Result<[TopAnimeMain.TopAnime], Error>) {
            self.result = result
        }
        
        func fetchTop(page: Int, subtype: AnimeTopSubtype, completion: @escaping (Result<[TopAnimeMain.TopAnime], Error>) -> Void) {
            completion(
                result
            )
        }
    }
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_whenSuccessfullyFetchAnimes_thenAnimesIsHandleByCompletion() {
        
        // given
        let expectation = self.expectation(description: "Top Animes is successfully handled")
        expectation.expectedFulfillmentCount = 2
        
        topAnimeWebRepository = TopAnimeWebRepositoryMock(result: .success(TopAnimeUseCaseTest.topAnimes))
        sut = DefaultTopAnimesReadUseCase(animeRepository: topAnimeWebRepository)
        
        
        var willFetchedAnimes: [TopAnimeMain.TopAnime] = []
        
        // when
        topAnimeWebRepository.fetchTop(page: 1, subtype: testedSubtype) { (result) in
            expectation.fulfill()
        }
        
        // then
        sut.getAnimes(page: 1, subtype: testedSubtype) { (result) in
            willFetchedAnimes = (try? result.get()) ?? []
            expectation.fulfill()
        }
        
        
        waitForExpectations(timeout: 4, handler: nil)
        XCTAssertEqual(willFetchedAnimes[0].title, TopAnimeUseCaseTest.topAnimes[0].title)
    }
    
    func test_whenFailToFetchTopAnimes_thenErrorIsHandleByCompletion_andReturnEmptyAnimes() {
        
        // given
        let expectation = self.expectation(description: "Failed To Fetch Anime")
        expectation.expectedFulfillmentCount = 2
        
        topAnimeWebRepository = TopAnimeWebRepositoryMock(result: .failure(HTTPError.invalidResponse))
        sut = DefaultTopAnimesReadUseCase(animeRepository: topAnimeWebRepository)


        var willFetchedAnimes: [TopAnimeMain.TopAnime] = []
        var willFetchedError: Error? = nil
        
        // when
        topAnimeWebRepository.fetchTop(page: 1, subtype: testedSubtype) { (result) in
            expectation.fulfill()
        }

        // then
        sut.getAnimes(page: 1, subtype: testedSubtype) { (result) in
            switch result {
            case.success(let animes):
                willFetchedAnimes = animes
            case .failure(let error):
                willFetchedError = error
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 4, handler: nil)
        XCTAssertNotNil(willFetchedError)
        XCTAssertTrue(willFetchedAnimes.isEmpty)
    }
    

}
