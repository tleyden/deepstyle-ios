
import UIKit

class DeepStyleJobViewController: UIViewController {
    
    @IBOutlet var photoImageView: UIImageView? = nil
    @IBOutlet var paintingImageView: UIImageView? = nil
    @IBOutlet var finishedImageView: UIImageView? = nil
    
    var photoImage: UIImage? = nil
    var paintingImage: UIImage? = nil
    var finishedImage: UIImage? = nil

    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.photoImageView?.image = self.photoImage
        self.paintingImageView?.image = self.paintingImage
        self.finishedImageView?.image = self.finishedImage
        
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

    override func updateViewConstraints() {
        super.updateViewConstraints()
        print("updateViewConstraints")
        NSLayoutConstraint.activateConstraints(
            [
                NSLayoutConstraint(
                    item: self.finishedImageView!,
                    attribute: .Top,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Top,
                    multiplier: 1,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.finishedImageView!,
                    attribute: .Height,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Height,
                    multiplier: 0.75,
                    constant: 0
                ),
                /*NSLayoutConstraint(
                    item: self.finishedImageView!,
                    attribute: .CenterX,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .CenterX,
                    multiplier: 1,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.finishedImageView!,
                    attribute: .Trailing,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Trailing,
                    multiplier: 1,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.finishedImageView!,
                    attribute: .Leading,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Leading,
                    multiplier: 1,
                    constant: 0
                ),*/
                NSLayoutConstraint(
                    item: self.photoImageView!,
                    attribute: .Bottom,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Bottom,
                    multiplier: 1,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.paintingImageView!,
                    attribute: .Bottom,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Bottom,
                    multiplier: 1,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.paintingImageView!,
                    attribute: .Height,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Height,
                    multiplier: 0.25,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.photoImageView!,
                    attribute: .Height,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Height,
                    multiplier: 0.25,
                    constant: 0
                ),
                /*NSLayoutConstraint(
                    item: self.photoImageView!,
                    attribute: .Width,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Width,
                    multiplier: 0.5,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.paintingImageView!,
                    attribute: .Width,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Width,
                    multiplier: 0.5,
                    constant: 0
                ),*/
            ]
        )

        /* self.photoImageView?.addConstraint(
            NSLayoutConstraint(
                item: self.finishedImageView!,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: self.photoImageView,
                attribute: .Top,
                multiplier: 1,
                constant: 0
            )
        ) */
        
        
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
