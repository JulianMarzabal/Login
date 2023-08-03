//
//  FirstViewViewModelTest.swift
//  ReuseTests
//
//  Created by Julian Marzabal on 23/07/2023.
//

import XCTest
@testable import Reuse

class FirstViewViewModelTest: XCTestCase {
    var sut: FirstViewViewModel!
    var api: APIMock!
    

    override func setUpWithError() throws {
        sut = FirstViewViewModel()
        api = APIMock()
        sut.api = api
    }

    override func tearDownWithError() throws {
        sut = nil
        api = nil
    }

    func testCreateModel() throws {

        let photoResult = PhotoResult.init(id: "2", urls: UrlsPhotos.init(full: "full", regular: "regular"))
        
        sut.createModel(photos: [photoResult])
        
        XCTAssertEqual(photoResult.id.count, 1)
    
    }
    
    func testFetchPhotos() {
        let photo1 = PhotoResult(id: "1", urls: .init(full: "2", regular: "2"))
        let photo2 = PhotoResult(id: "2", urls: .init(full: "3", regular: "4"))
        let photoModel = PhotoModel(total: 2, total_pages: 10, results: [photo1,photo2])
        api.arrayMock = photoModel
        
        let expectation = XCTestExpectation(description: "Fetch photos")
        XCTAssertTrue(sut.myPhotoModel.isEmpty)
        sut.fetchPhotos()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 ) {
                  
           
            expectation.fulfill()
                   
            
               }
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(self.sut.myPhotoModel.count, 2)
        
        
    }

  

}
