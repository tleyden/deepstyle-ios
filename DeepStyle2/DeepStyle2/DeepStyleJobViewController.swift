
import UIKit

class DeepStyleJobViewController: UIViewController {
    
    var photoImageView: UIImageView = UIImageView()
    var paintingImageView: UIImageView = UIImageView()
    var finishedImageView: UIImageView = UIImageView()
    
    var photoImage: UIImage? = nil
    var paintingImage: UIImage? = nil
    var finishedImage: UIImage? = nil
    
    
    /* var job: DeepStyleJob {
        get {
            return job
        }
        set {
            if let jobPhotoImage = job.sourceImage() {
                self.photoImage = jobPhotoImage
            }
            if let jobPaintingImage = job.styleImage() {
                self.paintingImage = jobPaintingImage
            }
            if let finishedImage = job.finishedImage() {
                self.finishedImage = finishedImage
            } else {
                self.finishedImage = UIImage(named: "icon-gear")
            }
        }
    }*/

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.addSubview(self.photoImageView)
        self.view.addSubview(self.paintingImageView)
        self.view.addSubview(self.finishedImageView)
        
        self.photoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.paintingImageView.translatesAutoresizingMaskIntoConstraints = false
        self.finishedImageView.translatesAutoresizingMaskIntoConstraints = false

        self.photoImageView.image = self.photoImage
        self.photoImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.paintingImageView.image = self.paintingImage
        self.paintingImageView.contentMode = UIViewContentMode.ScaleAspectFit
            
        self.finishedImageView.image = self.finishedImage
        self.finishedImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        addConstraints()
        addGestureRecognizers()
        fixFinishedImageView()
        
        let shareBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem:.Action, target: self, action: Selector("userDidTapShare"))
        self.navigationItem.rightBarButtonItem = shareBar
        
    }
    
    func fixFinishedImageView() {
        self.finishedImageView.image = rotatedFinishedImage()
    }
    
    func rotatedFinishedImage() -> UIImage {
        return fixFinishedImageViewOrientation(
            self.finishedImageView.image!,
            photoImage: self.photoImageView.image!
        )

    }
    
    func userDidTapShare() {
        
        if self.finishedImage != nil {
            let objectsToShare = [rotatedFinishedImage()]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
        
    }

    
    func addConstraints() {
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: self.finishedImageView,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Top,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: self.finishedImageView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 0.75,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: self.finishedImageView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: self.paintingImageView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 0.25,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: self.photoImageView,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Height,
                multiplier: 0.25,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: self.paintingImageView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 0.5,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: self.photoImageView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Width,
                multiplier: 0.5,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: self.photoImageView,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Bottom,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: self.paintingImageView,
                attribute: .Bottom,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Bottom,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: self.paintingImageView,
                attribute: .Leading,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Leading,
                multiplier: 1,
                constant: 0
            )
        )
        
        self.view.addConstraint(
            NSLayoutConstraint(
                item: self.photoImageView,
                attribute: .Trailing,
                relatedBy: .Equal,
                toItem: self.view,
                attribute: .Trailing,
                multiplier: 1,
                constant: 0
            )
        )
        
    }
    
    func addGestureRecognizers() {
        
        let photoTap = UITapGestureRecognizer(target: self, action:"photoImageViewTapped")
        photoTap.numberOfTapsRequired = 1
        self.photoImageView.userInteractionEnabled = true
        self.photoImageView.addGestureRecognizer(photoTap)
        
        let paintingTap = UITapGestureRecognizer(target: self, action:"paintingImageViewTapped")
        paintingTap.numberOfTapsRequired = 1
        self.paintingImageView.userInteractionEnabled = true
        self.paintingImageView.addGestureRecognizer(paintingTap)
        
        let finishedImageTap = UITapGestureRecognizer(target: self, action:"finishedImageViewTapped")
        finishedImageTap.numberOfTapsRequired = 1
        self.finishedImageView.userInteractionEnabled = true
        self.finishedImageView.addGestureRecognizer(finishedImageTap)
        
    }
    

    func finishedImageViewTapped() {
        
        // push a new view controller that only has the finished image
        let fullscreenImageViewController = FullScreenImageViewController()
        // fullScreenImageViewController.fullScreenImageView = self.finishedImageView
        // fullScreenImageViewController.setTheFullScreenImageView(self.finishedImageView)
        // fullscreenImageViewController.fullScreenImageView?.image = self.finishedImageView.image?
        let newCgIm = CGImageCreateCopy(self.finishedImageView.image?.CGImage)
        let newImage = UIImage(CGImage: newCgIm!, scale: self.finishedImageView.image!.scale, orientation: self.finishedImageView.image!.imageOrientation)
        // fullscreenImageViewController.fullScreenImageView?.image = newImage
        fullscreenImageViewController.fullScreenImage = newImage
        
        // fullscreenImageViewController.setTheFullScreenImageView(<#T##fullscreenImageViewToUse: UIImageView##UIImageView#>)
        self.navigationController?.pushViewController(fullscreenImageViewController, animated: true)
        
    }

    func photoImageViewTapped() {
        
        let currentPhotoImage = self.photoImageView.image
        let currentFinishedImage = self.finishedImageView.image
        
        self.photoImageView.image = currentFinishedImage
        self.finishedImageView.image = currentPhotoImage
        
    }
    
    func paintingImageViewTapped() {
        
        let currentPaintingImage = self.paintingImageView.image
        let currentFinishedImage = self.finishedImageView.image
        
        self.paintingImageView.image = currentFinishedImage
        self.finishedImageView.image = currentPaintingImage
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setJob(job: DeepStyleJob) {
        
        if let jobPhotoImage = job.sourceImage() {
            self.photoImage = jobPhotoImage
        }
        if let jobPaintingImage = job.styleImage() {
            self.paintingImage = jobPaintingImage
        }
        if let finishedImage = job.finishedImage() {
            self.finishedImage = finishedImage
        } else {
            self.finishedImage = UIImage(named: "icon-gear")
        }
        
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
