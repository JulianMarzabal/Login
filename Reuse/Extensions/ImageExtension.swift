//
//  ImageExtension.swift
//  Reuse
//
//  Created by Julian Marzabal on 06/06/2023.
//

import UIKit
import CoreVideo

extension UIImage {
    func pixelBuffer() -> CVPixelBuffer? {
        let width = Int(self.size.width)
        let height = Int(self.size.height)
        let attributes: [String: Any] = [
            kCVPixelBufferCGImageCompatibilityKey as String: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String: true
        ]
        
        var pixelBuffer: CVPixelBuffer?
        CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32BGRA, attributes as CFDictionary, &pixelBuffer)
        
        guard let target = pixelBuffer else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(target, CVPixelBufferLockFlags(rawValue: 0))
        
        let colorspace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: CVPixelBufferGetBaseAddress(target), width: width, height: height, bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(target), space: colorspace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) else {
            return nil
        }
        
        context.translateBy(x: 0, y: CGFloat(height))
        context.scaleBy(x: 1, y: -1)
        
        UIGraphicsPushContext(context)
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        UIGraphicsPopContext()
        
        CVPixelBufferUnlockBaseAddress(target, CVPixelBufferLockFlags(rawValue: 0))
        
        return target
    }
   
    func resized(to targetSize: CGSize) -> CVPixelBuffer? {
            let width = Int(targetSize.width)
            let height = Int(targetSize.height)
            
            let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue,
                         kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
            
            var pixelBuffer: CVPixelBuffer?
            let status = CVPixelBufferCreate(kCFAllocatorDefault,
                                             width,
                                             height,
                                             kCVPixelFormatType_32ARGB,
                                             attrs,
                                             &pixelBuffer)
            
            guard let buffer = pixelBuffer, status == kCVReturnSuccess else {
                return nil
            }
            
            CVPixelBufferLockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))
            let pixelData = CVPixelBufferGetBaseAddress(buffer)
            
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let context = CGContext(data: pixelData,
                                    width: width,
                                    height: height,
                                    bitsPerComponent: 8,
                                    bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
                                    space: colorSpace,
                                    bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
            
            context?.translateBy(x: 0, y: CGFloat(height))
            context?.scaleBy(x: 1.0, y: -1.0)
            
            UIGraphicsPushContext(context!)
            self.draw(in: CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height))
            UIGraphicsPopContext()
            
            CVPixelBufferUnlockBaseAddress(buffer, CVPixelBufferLockFlags(rawValue: 0))
            
            return buffer
        }
    
    func resizeUIImage(to size: CGSize) -> UIImage? {
           UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
           self.draw(in: CGRect(origin: .zero, size: size))
           let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return resizedImage
       }
    
    
    }


    








