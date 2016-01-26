
import UIKit

@objc(FullScreenImageViewController) class FullScreenImageViewController: UIViewController {

    @IBOutlet var fullScreenImageView: UIImageView? = nil
    
    var fullScreenImage: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fullScreenImageView?.image = self.fullScreenImage
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func setTheFullScreenImageView(fullscreenImageViewToUse: UIImageView) {
        self.fullScreenImageView = fullscreenImageViewToUse
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
