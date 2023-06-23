//
//  PhotoModel.swift
//  Reuse
//
//  Created by Julian Marzabal on 20/06/2023.
//

import Foundation


struct PhotoModel:Codable {
    let total: Int
    let  total_pages: Int
    let results: [PhotoResult]
    
}

struct PhotoResult: Codable {
    let id: String
    let urls: UrlsPhotos
    
}

struct UrlsPhotos: Codable {
    let full: String
    let regular: String
}


// My Model

struct myPhotoModel {
    let id: String
    let url: String
}
