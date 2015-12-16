
// Access point for the currently logged in user

import Foundation

class LoginSession {
    
    static let sharedInstance = LoginSession()

    var userId: String? = nil
    
    func getLoggedInUserId() throws -> String {
        if let loggedInUserId = userId {
            return loggedInUserId
        }
        throw LoginSessionError.UserNotLoggedIn
    }
    
}

enum LoginSessionError: ErrorType {
    case UserNotLoggedIn
}