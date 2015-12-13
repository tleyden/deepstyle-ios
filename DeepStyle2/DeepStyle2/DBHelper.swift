    //
//  DBHelper.swift
//  DeepStyle2
//
//  Created by Traun Leyden on 12/13/15.
//  Copyright © 2015 DeepStyle. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

class DBHelper {
    
    // The local DB name
    static let databaseName = "deepstyle"
    
    // The remote database URL to sync with.
    static let serverDbURL = NSURL(string: "http://demo.couchbasemobile.com:4984/deepstyle/")!
    
    static let sharedInstance = DBHelper()
    
    var database: CBLDatabase? = nil
    
    init() {
        do {
            try database = CBLManager.sharedInstance().databaseNamed(DBHelper.databaseName)
        }
        catch {
            print("Error initializing database: \(error)")
        }
        CBLManager.enableLogging("SyncVerbose")
    }
    
    func startReplicationFromFacebookToken() throws {
        
        if FBSDKAccessToken.currentAccessToken() == nil {
            throw DBHelperError.FBUserNotLoggedIn
        }
        
        let accessTokenStr = FBSDKAccessToken.currentAccessToken().tokenString
        
        let fbAuthenticator = CBLAuthenticator.facebookAuthenticatorWithToken(accessTokenStr)

        let push = database?.createPushReplication(DBHelper.serverDbURL)
        if push == nil {
            throw DBHelperError.ReplicationInitializationError
        }
    
        push?.authenticator = fbAuthenticator
        push?.continuous = true
        push?.start()
                
    }
    
    func createDeepStyleJob(sourceImage: UIImage, styleImage: UIImage) throws -> DeepStyleJob {
        
        let deepStyleJob:DeepStyleJob = DeepStyleJob(forNewDocumentInDatabase: database!)
        deepStyleJob.testField = "foo"
        try deepStyleJob.save()
        return deepStyleJob
        
    }

    
}

enum DBHelperError: ErrorType {
    case FBUserNotLoggedIn
    case ReplicationInitializationError
}