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
    func dismissWithImages(sourceImage: UIImage, styleImage: UIImage)
}