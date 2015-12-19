//
//  LoginViewController.swift
//  DeepStyle
//
//  Created by Traun Leyden on 12/12/15.
//  Copyright © 2015 DeepStyle. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

// TODO: figure out why using a nib didn't work
// TODO: figure out why FBSDKAccessToken.currentAccessToken() is always nil when restarting the app

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, PresenterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let accessToken = FBSDKAccessToken.currentAccessToken() {
            print(accessToken)
        } else {
            print("no access token")
        }
        
        // Add FB login button
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        loginView.delegate = self
        loginView.readPermissions = ["public_profile", "user_friends", "email"]
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        
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
                // Process error
                print("Error getting facebook ID: \(error)")
            }
            else
            {
                let userId = result.valueForKey("id") as! String
                LoginSession.sharedInstance.userId = userId
                
                do {
                    try DBHelper.sharedInstance.startReplicationFromFacebookToken()
                } catch {
                    print("Error starting replication: \(error)")
                }
                
            }
        })
        
        showRecentGalleryViewController()
    }
    
    func returnUserData()
    {
        
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
