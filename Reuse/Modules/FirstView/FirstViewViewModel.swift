//
//  FirstViewViewModel.swift
//  Reuse
//
//  Created by Julian Marzabal on 06/06/2023.
//

import Foundation
import UIKit
import CoreML

class FirstViewViewModel {
    func modeling() {
        if let modelURL = Bundle.main.url(forResource: "YOLOv3Tiny", withExtension: "mlmodelc") {
            do {
                print("Estamos en el do")
                //let model = try MLModel(contentsOf: modelURL)
                         guard let inputImage = UIImage(named: "inputCar") else { return }
                guard let resizedImage = inputImage.resize(to: CGSize(width: 416, height: 416)) else {return}
                         guard let pixelBuffer = resizedImage.pixelBuffer() else { return }
                         
                         // Crear una instancia de tu modelo
                         let yoloModel = try YOLOv3Tiny(configuration: MLModelConfiguration())
                
                         // Crear una instancia de YOLOv3TinyInput
                         
                let input = YOLOv3TinyInput(image: pixelBuffer)
                
               
                
                
                let predictions = try yoloModel.prediction(input: input)
                let outputDescription = yoloModel.model.modelDescription.outputDescriptionsByName
                print(outputDescription)
                
                
                
                let output = YOLOv3TinyOutput(confidence: predictions.confidence, coordinates: predictions.coordinates)
                let outputName = output.featureNames
                for outpu in outputName {
                    for algo in outpu {
                        print(algo)
                    }
                    print("-_--------------------")
                  
                }
                
             
                
                
                
                
    
            } catch {
                print("Error al cargar el modelo: \(error)")
            }
        } else {
            print("No se encontró el archivo del modelo.")
        }
    }
    
}
