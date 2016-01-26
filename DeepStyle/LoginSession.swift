
// Access point for the currently logged in user

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class LoginSession {
    
    static let sharedInstance = LoginSession()

    func getLoggedInUserId() throws -> String {
        
        if let accessToken = FBSDKAccessToken.currentAccessToken() {
            
            if let facebookUserId = LoginSession.sharedInstance.lookupSavedUserIdForAccessToken(accessToken.tokenString) {
                return facebookUserId
            }
            print("Could not lookup facebookUserId from \(accessToken.tokenString)")
            throw LoginSessionError.UserNotLoggedIn
            
        } else {
            throw LoginSessionError.UserNotLoggedIn
        }
        
    }
    
    func saveUserLoginInfo(userId: String) throws {
        try saveUserIdForCurrentFBAccessToken(userId)
    }
    
    // LoginSession.sharedInstance.lookupSavedUserIdForAccessToken(accessToken)
    func lookupSavedUserIdForAccessToken(accessToken: String) -> String? {
        return DBHelper.sharedInstance.lookupLocalDocKV(accessToken)
    }
    
    func saveUserIdForCurrentFBAccessToken(userId: String) throws {
        if let accessToken = FBSDKAccessToken.currentAccessToken() {
            let localDocKey = accessToken.tokenString
            try DBHelper.sharedInstance.setLocalDocKV(localDocKey, value: userId)
        }
    }
    
    func logout() throws {
        if let accessToken = FBSDKAccessToken.currentAccessToken() {
            let localDocKey = accessToken.tokenString
            try DBHelper.sharedInstance.setLocalDocKV(localDocKey, value: "")
            FBSDKAccessToken.setCurrentAccessToken(nil)
        }
    }
    
}

enum LoginSessionError: ErrorType {
    case UserNotLoggedIn
}