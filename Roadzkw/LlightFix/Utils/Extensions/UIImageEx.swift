/*************************  *************************/
//
//  UIImageEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//


import UIKit

extension UIImage{
    func blur(distance:Int) -> UIImage {
        let inputImage = CIImage(cgImage: (self.cgImage)!)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: "inputImage")
        filter?.setValue(distance, forKey: "inputRadius")
        let blurred = filter?.outputImage
        
        var newImageSize: CGRect = (blurred?.extent)!
        newImageSize.origin.x += (newImageSize.size.width - (self.size.width)) / 2
        newImageSize.origin.y += (newImageSize.size.height - (self.size.height)) / 2
        newImageSize.size = (self.size)
        
        let resultImage: CIImage = filter?.value(forKey: "outputImage") as! CIImage
        let context: CIContext = CIContext.init(options: nil)
        let cgimg: CGImage = context.createCGImage(resultImage, from: newImageSize)!
        let blurredImage: UIImage = UIImage.init(cgImage: cgimg)
        return  blurredImage
    }
    var imageBaseLang : UIImage{
        return self.imageFlippedForRightToLeftLayoutDirection()
    }
}
