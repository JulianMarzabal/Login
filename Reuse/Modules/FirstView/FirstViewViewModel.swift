//
//  FirstViewViewModel.swift
//  Reuse
//
//  Created by Julian Marzabal on 06/06/2023.
//

import Foundation
import UIKit
import CoreML
import Vision
import SDWebImage

class FirstViewViewModel {
    
    var api: APIProtocol = API.shared
    //let model = Resnet50FP16()
    var myPhotoModel: [myPhotoModel] = []
    
    func modeling() {
    let image = UIImage(named: "andyInput")
        guard let inputImage = image?.resized(to: CGSize(width: 224, height: 224)) else {return}
    
    let input = Resnet50FP16Input(image:inputImage)
        do {
            let model = try Resnet50FP16(configuration: MLModelConfiguration())
            let predictions = try model.prediction(input: input)
            let output = Resnet50FP16Output(classLabelProbs: predictions.classLabelProbs, classLabel: predictions.classLabel)
            
            let maxProbability = output.classLabelProbs.max { $0.value < $1.value }
            let predictedClassLabel = maxProbability?.key
            
            let porcentProbabilities = maxProbability?.value.toPercentageString()
            

            // Imprimir la predicción final
            print(predictedClassLabel)
            print(porcentProbabilities)
            
            
            
        } catch {
            print(error.localizedDescription)
        }
        
        
           
        
        
    }
    func fetchPhotos() {
            Task {
                do {
                    let photoModel = try await api.getPhotos()
                   // let ids = photoModel.results.map { $0.id }
                   // let urls = photoModel.results.map {$0.urls.full}
                    print("--------------------")
                    let photoResult = photoModel.results
                    createModel(photos: photoResult)
                   
                    
                    
                    print("successfull data")
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
    
    func createModel(photos: [PhotoResult]) {
        myPhotoModel = []
        
        for photo in photos {
            myPhotoModel.append(.init(id:photo.id, url: photo.urls.full))
            
            print(myPhotoModel)
        }
    }
    
    func setimage(){
        let url = myPhotoModel.first?.url
        
    }
    
   
    
    
    
    
    
  
}
