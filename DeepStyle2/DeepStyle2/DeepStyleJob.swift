
import Foundation

class DeepStyleJob: CBLModel {
    
    static let docType = "job"
    
    @NSManaged var state: String?
    @NSManaged var owner: String?
    
    
}