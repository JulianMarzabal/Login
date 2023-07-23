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

enum State{
    case done
    case loading
    
}

struct ImageProcessed {
    var predictedLabel: String
    var probability: String
    var image: URL
    var predictionText: String {
        "Prediction: \(predictedLabel.replacingOccurrences(of: ", ", with: "\n"))"
    }
    var probabilityText: String {
        "Probability: \(probability)"
    }

    
    
}



class FirstViewViewModel {
    private var pageIndex:Int = 1
    private var firstLoad: Bool = true
    private var state: State = .done
    var api: APIProtocol = API.shared
    //let model = Resnet50FP16()
    var myPhotoModel: [myPhotoModel] = []
    var currentIndex = 0
    var onNextImageHandler: ((ImageProcessed)->Void)?
    
    private var processedImage: ImageProcessed?{
        didSet {
            guard let processedImage = processedImage else {
                return
            }
            onNextImageHandler?(processedImage)

        }
    }
    
    
    func modeling(urlInput: URL) {
        

        do {
          
            let input = try Resnet50FP16Input(imageAt: urlInput)
            let model = try Resnet50FP16(configuration: MLModelConfiguration())
            let predictions = try model.prediction(input: input)
            let output = Resnet50FP16Output(classLabelProbs: predictions.classLabelProbs, classLabel: predictions.classLabel)
            
            let maxProbability = output.classLabelProbs.max { $0.value < $1.value }
            guard let predictedLabel = maxProbability?.key, let probabilty = maxProbability?.value.toPercentageString() else { return }
           
            processedImage = .init(predictedLabel: predictedLabel , probability: probabilty, image: urlInput)
            
   
            
        } catch {
            print(error.localizedDescription)
        }
        
        
           
        
        
    }
    func fetchPhotos() {
        state = .loading
            Task {
                do {
                    let photoModel = try await api.getPhotos(page: pageIndex)
                    pageIndex += 1
                    let photoResult = photoModel.results
                    createModel(photos: photoResult)
                    if firstLoad {
                        state = .done
                        processImage()
                        firstLoad = false
                    }
                    
                   
                    print("successfull data")
                } catch {
                    print(error.localizedDescription)
                }
                state = .done
            }
        
    }
    
    func createModel(photos: [PhotoResult]) {
       
        
        for photo in photos {
            myPhotoModel.append(.init(id:photo.id, url: photo.urls.full))
            
            print(myPhotoModel)
        }
    }
    
//    func getNextImageUrl() -> URL? {
////
////        currentIndex = (currentIndex + 1) % myPhotoModel.count
////        return URL(string: myPhotoModel[currentIndex].url)
//
//    }

    
    func processImage() {
        guard currentIndex < myPhotoModel.count, state == .done else {return}
        
        guard let url = URL(string: myPhotoModel[currentIndex].url) else {return}
        modeling(urlInput: url)
        currentIndex = (currentIndex + 1)
        if currentIndex == myPhotoModel.count - 1 {
            pageIndex += 1
            fetchPhotos()
        }
    }
    
    
    
    
    
  
}
