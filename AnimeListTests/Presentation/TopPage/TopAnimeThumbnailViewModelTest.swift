//
//  AnimeListTests.swift
//  AnimeListTests
//
//  Created by Johnny on 4/12/20.
//  Copyright © 2020 Johnny. All rights reserved.
//

import XCTest
@testable import AnimeList

class TopAnimeThumbnailViewModelMock: TopAnimeThumbnailViewModel {
    
    var rank: String
    
    var id: Int

    var imageURL: URL
    
    var title: String
    var score: String
    var members: String
    
    var type: String
    var episode: String
    
    
    init() {
        self.rank = "1"
        self.id = 100
        self.imageURL = URL(string: "imageURL")!
        self.title = "Attack On Titan"
        self.score = "9.0"
        self.members = "1000000"
        self.type = "TV"
        self.episode = "25"
    }
    
    
}

class TopAnimeThumbnailViewModelTest: XCTestCase {
    
    var sut: TopAnimeThumbnailViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = TopAnimeThumbnailViewModelMock()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_viewModelReceiveAllVariables() {
        XCTAssertEqual(sut.rank, "1")
        XCTAssertEqual(sut.id, 100)
        
        XCTAssertEqual(sut.imageURL, URL(string: "imageURL"))
        XCTAssertEqual(sut.title, "Attack On Titan")
        XCTAssertEqual(sut.score, "9.0")
        
        XCTAssertEqual(sut.members, "1000000")
        XCTAssertEqual(sut.type, "TV")
        XCTAssertEqual(sut.episode, "25")
    }

}
