//
//  TopAnimesPageViewModelTest.swift
//  AnimeListTests
//
//  Created by Johnny on 4/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import XCTest
@testable import AnimeList

class TopAnimeWebServiceMock: TopAnimeWebService {
    func fetchTop(page: Int, subtype: AnimeTopSubtype, completion: @escaping (Result<[TopAnimeDTO], Error>) -> Void) {
    }
    
    var topItemsLoadPerPage: Int = 50
}

class TopAnimesPageViewModelTest: XCTestCase {
    
    var sut: TopAnimesPageViewModel!
    var topAnimeWebService: TopAnimeWebService = TopAnimeWebServiceMock()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = DefaultTopAnimesPageViewModel(animeWebSerivce: topAnimeWebService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    

}
