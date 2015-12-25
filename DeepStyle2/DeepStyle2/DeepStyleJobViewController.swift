
import UIKit

class DeepStyleJobViewController: UIViewController {
    
    var photoImageView: UIImageView = UIImageView()
    var paintingImageView: UIImageView = UIImageView()
    var finishedImageView: UIImageView = UIImageView()
    
    var photoImage: UIImage? = nil
    var paintingImage: UIImage? = nil
    var finishedImage: UIImage? = nil

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        /*self.photoImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.paintingImageView.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        self.finishedImageView.frame = CGRect(x: 0, y: 200, width: 100, height: 100)
        */
        
        self.view.addSubview(self.photoImageView)
        self.view.addSubview(self.paintingImageView)
        self.view.addSubview(self.finishedImageView)
        
        self.photoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.paintingImageView.translatesAutoresizingMaskIntoConstraints = false
        self.finishedImageView.translatesAutoresizingMaskIntoConstraints = false

        self.photoImageView.image = self.photoImage
        self.paintingImageView.image = self.paintingImage
        self.finishedImageView.image = self.finishedImage
        
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
        /*
        NSLayoutConstraint.activateConstraints(
            [
                NSLayoutConstraint(
                    item: self.finishedImageView,
                    attribute: .Top,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Top,
                    multiplier: 1,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.finishedImageView,
                    attribute: .Height,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Height,
                    multiplier: 0.75,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.finishedImageView,
                    attribute: .Width,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Width,
                    multiplier: 0.75,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.paintingImageView,
                    attribute: .Height,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Height,
                    multiplier: 0.25,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.photoImageView,
                    attribute: .Height,
                    relatedBy: .Equal,
                    toItem: self.view,
                    attribute: .Height,
                    multiplier: 0.25,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.photoImageView,
                    attribute: .Top,
                    relatedBy: .Equal,
                    toItem: self.finishedImageView,
                    attribute: .Bottom,
                    multiplier: 1,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.paintingImageView,
                    attribute: .Top,
                    relatedBy: .Equal,
                    toItem: self.finishedImageView,
                    attribute: .Bottom,
                    multiplier: 1,
                    constant: 0
                ),
                NSLayoutConstraint(
                    item: self.paintingImageView,
                    attribute: .Leading,
                    relatedBy: .Equal,
                    toItem: self.photoImageView,
                    attribute: .Trailing,
                    multiplier: 1,
                    constant: 0
                )
            ]
        )
    */

        
        
        
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
