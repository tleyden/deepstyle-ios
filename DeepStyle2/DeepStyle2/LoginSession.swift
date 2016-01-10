
// Access point for the currently logged in user

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class LoginSession {
    
    static let sharedInstance = LoginSession()

    var userId: String? = nil
    
    func getLoggedInUserId() throws -> String {
        if let loggedInUserId = userId {
            return loggedInUserId
        }
        throw LoginSessionError.UserNotLoggedIn
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
    
    func logout() {
        FBSDKAccessToken.setCurrentAccessToken(nil)
    }
    
}

enum LoginSessionError: ErrorType {
    case UserNotLoggedIn
}