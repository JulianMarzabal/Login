//
//  FirstViewController.swift
//  Reuse
//
//  Created by Julian Marzabal on 04/06/2023.
//

import UIKit
import CoreML

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        modeling()
        title = "first View controller"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    func modeling() {
        if let modelURL = Bundle.main.url(forResource: "YOLOv3Tiny", withExtension: "mlmodelc") {
            do {
                let model = try MLModel(contentsOf: modelURL)
                         guard let inputImage = UIImage(named: "firstInput") else { return }
                guard let resizedImage = inputImage.resizeImage(inputImage, to:CGSize(width: 416, height: 416)) else { return }
                         guard let pixelBuffer = resizedImage.pixelBuffer() else { return }
                         
                         // Crear una instancia de tu modelo
                         let yoloModel = try YOLOv3Tiny(configuration: MLModelConfiguration())
                
                
                
                         
                         // Crear una instancia de YOLOv3TinyInput
                         let yoloInput = YOLOv3TinyInput(image: pixelBuffer)
                
                         // Obtener la descripción del modelo
                         let modelDescription = yoloModel.model.modelDescription
                
                         
                        
                         
                         // Realizar inferencias con el pixelBuffer
                         let predictions = try yoloModel.predictions(inputs: [yoloInput])
                
                
    
                
                         
                         // Procesar las predicciones obtenidas
                         for prediction in predictions {
                             print(prediction)
                             let classIndex = prediction.featureNames
                             let confidence = prediction.confidence
                             let boundingBox = prediction.coordinates
                             
                         
                             
                             print(classIndex)
                             print(confidence)
                             print(boundingBox)
                             // Realizar las acciones necesarias con las predicciones
                             // ...
                         }
                
                
                
    
            } catch {
                print("Error al cargar el modelo: \(error)")
            }
        } else {
            print("No se encontró el archivo del modelo.")
        }
    }
    
    

    

}
