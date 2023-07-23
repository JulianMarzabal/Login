//
//  APIMock.swift
//  ReuseTests
//
//  Created by Julian Marzabal on 18/07/2023.
//


@testable import Reuse
class APIMock: APIProtocol {
    
    var arrayMock: PhotoModel = .init(total: 1, total_pages: 1, results: [])
    func getPhotos(page: Int) async throws -> PhotoModel {
        return arrayMock
    }
    
    
}
