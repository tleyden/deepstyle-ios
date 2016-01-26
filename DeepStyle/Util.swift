//
//  Util.swift
//  DeepStyle
//
//  Created by Traun Leyden on 12/12/15.
//  Copyright © 2015 DeepStyle. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterViewController {
    func dismiss()
}

protocol SourceAndStyleImageReciever {
    func dismissWithImages(sourceImage: UIImage, styleImage: UIImage) throws
}

func fixFinishedImageViewOrientation(finishedImage: UIImage, photoImage: UIImage) -> UIImage {
    
    // set the orientation of the finished image view to the same orientation of the
    // photo image view
    
    let newOrientatation = photoImage.imageOrientation
    
    let rotatedImage: UIImage = UIImage(CGImage: finishedImage.CGImage!,
        scale: 1.0 ,
        orientation: newOrientatation)
    
    return rotatedImage
    
}