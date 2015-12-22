
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

// TODO: figure out why using a nib didn't work -- button was not centered

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, PresenterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add FB login button
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        loginView.delegate = self
        loginView.readPermissions = ["public_profile", "user_friends", "email"]
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        
        // if we're logged in, fetch the user id from storage and then show the gallery
        if let accessToken = FBSDKAccessToken.currentAccessToken() {
            
            let facebookUserId = LoginSession.sharedInstance.lookupSavedUserIdForAccessToken(accessToken.tokenString)
            LoginSession.sharedInstance.userId = facebookUserId
            
            do {
                try DBHelper.sharedInstance.startReplicationFromFacebookToken()
            } catch {
                self.showError("Oops!  Error starting replication", error: error)
            }
            
            self.showNextButton()
            
        }
        
    }
    
    func showNextButton() {
        
        // add a button to skip to the next screen
        // TODO: should happen automatically, may need to rework view controllers for this
        let nextScreenButton = UIButton()
        nextScreenButton.setTitle("Next", forState: .Normal)
        nextScreenButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        nextScreenButton.frame = CGRectMake(0, 0, 50, 25)
        self.view.addSubview(nextScreenButton)
        nextScreenButton.center = CGPointMake(self.view.center.x, self.view.center.y + 50)
        nextScreenButton.addTarget(self, action: "showRecentGalleryViewController", forControlEvents: .TouchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                self.showError("Oops!  Error getting facebook ID", error: error)
            }
            else
            {
                let userId = result.valueForKey("id") as! String
                LoginSession.sharedInstance.userId = userId
                do {
                    try LoginSession.sharedInstance.saveUserIdForCurrentFBAccessToken(userId)
                } catch {
                    self.showError("Oops!  Error saving user ID", error: error)
                }
                
                do {
                    try DBHelper.sharedInstance.startReplicationFromFacebookToken()
                } catch {
                    self.showError("Oops!  Error starting replication", error: error)
                }
                
            }
        })
        
        showRecentGalleryViewController()
    }
    
    func returnUserData()
    {
        
    }
    
    
    func showError(msg: String, error: ErrorType) {
        
        print("Error: \(msg) - \(error)")
        let alert = UIAlertController(
            title: "Alert",
            message: "Oops! \(msg) - \(error)",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func showRecentGalleryViewController() {
        
        let recentGalleryVewController = GalleryViewController()
        
        // register ourselves as the presenter view controller delegate, so we get called back
        // when this view wants to get rid of itself
        recentGalleryVewController.presenterViewController = self
        
        let nav = UINavigationController(rootViewController: recentGalleryVewController)
        self.presentViewController(nav, animated: true, completion: nil)
        
        if let accessToken = FBSDKAccessToken.currentAccessToken() {
            print(accessToken)
        } else {
            print("no access token")
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("loginButtonDidLogOut")
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        print("loginButtonWillLogin")
        return true
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
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
