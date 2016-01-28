
import UIKit
import Crashlytics


// Note regarding @objc(AddDeepStyleViewController) -- this is needed to workaround for crash where all IBOutlets are nil with iOS 8.x
// http://bit.ly/1JHyDzo + http://bit.ly/1JHyDzo
@objc(AddDeepStyleViewController) class AddDeepStyleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // the view controller that spawned us will receive our images back, so it registers as a SourceAndStyleImageReciever
    var sourceAndStyleReceiver : SourceAndStyleImageReciever? = nil
    
    var presenterViewController: PresenterViewController? = nil
    
    var photoImage: UIImage? = nil
    
    @IBOutlet var choosePhotoButton: UIButton? = nil
    @IBOutlet var photoImageView: UIImageView? = nil

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancel:")
        self.navigationItem.leftBarButtonItem = cancelButton;
        
        let nextButton = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Plain, target: self, action: "create:")
        self.navigationItem.rightBarButtonItem = nextButton;
        
        self.navigationItem.title = "Choose Photo"
        
    }

    func cancel(sender: UIBarButtonItem) {
        presenterViewController?.dismiss()
    }
    
    func showError(error: ErrorType) {
        
        print("Error: \(error)")
        let alert = UIAlertController(
            title: "Alert",
            message: "Oops! \(error)",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    
    @IBAction func create(sender: AnyObject) {
        
        if let photo = photoImage {
            // TODO: push AddDeepStylePaintingImage to stack
            print("photo: \(photo)")
            let addPainting = AddDeepStylePaintingViewController()
            self.navigationController?.pushViewController(addPainting, animated: true)  
            
        } else {
            showError(AddJobError.MissingImage)
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.photoImage = image
            self.photoImageView!.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func doPick (sender:AnyObject!) {
        
        let src = UIImagePickerControllerSourceType.PhotoLibrary
        let ok = UIImagePickerController.isSourceTypeAvailable(src)
        if !ok {
            return
        }
        
        let arr = UIImagePickerController.availableMediaTypesForSourceType(src)
        if arr == nil {
            return
        }
        let picker = UIImagePickerController() // see comments below for reason
        picker.sourceType = src
        picker.mediaTypes = arr!
        picker.delegate = self
        
        picker.allowsEditing = false // try true
        
        // this will automatically be fullscreen on phone and pad, looks fine
        // note that for .PhotoLibrary, iPhone app must permit portrait orientation
        // if we want a popover, on pad, we can do that; just uncomment next line
        // picker.modalPresentationStyle = .Popover
        self.presentViewController(picker, animated: true, completion: nil)
        // ignore:
        if let pop = picker.popoverPresentationController {
            let v = sender as! UIView
            pop.sourceView = v
            pop.sourceRect = v.bounds
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

enum AddJobError: ErrorType {
    case MissingImage
}
