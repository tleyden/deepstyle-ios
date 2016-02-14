
import Foundation

class DeepStyleJob: CBLModel {
    
    static let docType = "job"
    
    static let StateNotReadyToProcess = "NOT_READY_TO_PROCESS"
    static let StateReadyToProcess = "READY_TO_PROCESS"
    static let StateBeingProcessed = "BEING_PROCESSED"
    static let StateProcessingSuccessful = "PROCESSING_SUCCESSFUL"
    static let StateProcessingFailed = "PROCESSING_FAILED"
    
    @NSManaged var state: String?
    @NSManaged var owner: String?
    @NSManaged var owner_devicetoken: String?
    
    func styleImage() -> UIImage? {
        return imageAttachmentByName("style_image")
    }
    
    func sourceImage() -> UIImage? {
        return imageAttachmentByName("source_image")
    }
    
    func finishedImage() -> UIImage? {
        return imageAttachmentByName("result_image")
    }
    
    func imageAttachmentByName(imageName: String) -> UIImage? {
        if let imageAttachment = self.attachmentNamed(imageName) {
            return UIImage(data: imageAttachment.content!)
        }
        return nil
    }
    
}