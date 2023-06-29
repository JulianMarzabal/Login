//
//  api.swift
//  Reuse
//
//  Created by Julian Marzabal on 20/06/2023.
//

import Foundation

protocol APIProtocol {
    func getPhotos(page:Int) async throws -> PhotoModel
}


class API:APIProtocol {
    static let shared = API()
   // var clientID:String?
    
    func getPhotos(page:Int) async throws -> PhotoModel {
        let clientID = "vc-_JDHKzCZRbOiEPs3VFhXw2bqK8MMOwWfU5L77L6U"
        
        let endpoint = "https://api.unsplash.com/search/photos?page=\(page)&query=animal&client_id=\(clientID)"
        guard let url = URL(string: endpoint) else {
            throw APIError.invalidURL
            
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(PhotoModel.self, from: data)
        }catch {
            print("se metio al catc")
            throw APIError.invalidData
        }
        
        
    }
    
    
    
    
    
}
