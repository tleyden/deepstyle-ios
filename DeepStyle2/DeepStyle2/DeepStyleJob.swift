
import Foundation

class DeepStyleJob: CBLModel {
    
    static let docType = "job"
    
    @NSManaged var state: String?
    @NSManaged var owner: String?
    
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