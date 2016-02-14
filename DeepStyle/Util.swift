
import Foundation
import UIKit
import CRToast

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

func showError(errorText: String) {
    
    let options: NSDictionary = [
        kCRToastTextKey : errorText,
        kCRToastTextAlignmentKey : NSTextAlignment.Center.rawValue,
        kCRToastBackgroundColorKey : UIColor.redColor(),
        kCRToastAnimationInTypeKey : CRToastAnimationType.Gravity.rawValue,
        kCRToastAnimationOutTypeKey : CRToastAnimationType.Gravity.rawValue,
        kCRToastAnimationInDirectionKey : CRToastAnimationDirection.Top.rawValue,
        kCRToastAnimationOutDirectionKey : CRToastAnimationDirection.Top.rawValue,
        kCRToastTimeIntervalKey: NSTimeInterval(5.0),
        kCRToastNotificationTypeKey: CRToastType.StatusBar.rawValue,
    ]
    CRToastManager.showNotificationWithOptions(options as [NSObject : AnyObject], apperanceBlock: { () -> Void in
        print("Showing error notification \(errorText)")
        }, completionBlock: { () -> Void in
            print("Error notification finished \(errorText)")
    })
    
}
