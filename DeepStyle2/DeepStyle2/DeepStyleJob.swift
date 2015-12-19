//
//  DeepStyleJob.swift
//  DeepStyle2
//
//  Created by Traun Leyden on 12/13/15.
//  Copyright © 2015 DeepStyle. All rights reserved.
//

import Foundation

class DeepStyleJob: CBLModel {
    
    static let docType = "job"
    
    @NSManaged var state: String?
    @NSManaged var owner: String?
    
    
}