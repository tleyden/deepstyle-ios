
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

// TODO: figure out why using a nib didn't work -- button was not centered
// RE TODO: need to add constraints

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, PresenterViewController {

    var presenterViewController: PresenterViewController? = nil
    var activityIndicator: UIActivityIndicatorView? = nil
    
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
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        print("loginButton didCompleteWithResult called with result: \(result) error: \(error)")
        
        showActivityIndicator()
        
        if (error != nil)
        {
            self.showError("Error doing facebook login", error: error)
            return
        }
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if (error != nil)
            {
                self.showError("Error getting facebook ID", error: error)
            }
            else
            {
                let userId = result.valueForKey("id") as! String
                LoginSession.sharedInstance.userId = userId
                do {
                    try LoginSession.sharedInstance.saveUserIdForCurrentFBAccessToken(userId)
                } catch {
                    self.showError("Error saving user ID", error: error)
                }
                
                do {
                    try DBHelper.sharedInstance.startReplicationFromFacebookToken()
                } catch {
                    self.showError("Error starting replication", error: error)
                }
                
                if FBSDKAccessToken.currentAccessToken() != nil {
                    self.presenterViewController?.dismiss()
                } else {
                    self.showError("Error doing facebook login -- no access token", error: DBHelperError.FBUserNotLoggedIn)
                }
                
                self.hideActivityIndicator()
                
            }
        })
        
        
        
        
    }
    
    func showActivityIndicator() {
        
        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        
        self.activityIndicator!.center=self.view.center
        self.activityIndicator!.center.y += 50  // move it below the fb button
        self.activityIndicator!.startAnimating()
        self.view.addSubview(self.activityIndicator!)
        
    }
    
    func hideActivityIndicator() {
        self.activityIndicator?.removeFromSuperview()
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
