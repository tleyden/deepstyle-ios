
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
