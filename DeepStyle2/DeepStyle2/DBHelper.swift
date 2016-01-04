

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

// All database access should go through this class

class DBHelper {
    
    // The local DB name
    static let databaseName = "deepstyle"
    
    // The remote database URL to sync with.
    static let serverDbURL = NSURL(string: "http://demo.couchbasemobile.com:4984/deepstyle/")!
    
    static let sharedInstance = DBHelper()
    
    var database: CBLDatabase? = nil
    
    init() {
        do {
            
            CBLManager.sharedInstance().storageType = kCBLForestDBStorage
            
            // new replicator -- not working
            // dbmgr.replicatorClassName = @"CBLBlipReplicator";
            // dbmgr.dispatchQueue = dispatch_get_main_queue();
            
            try database = CBLManager.sharedInstance().databaseNamed(DBHelper.databaseName)
            
        }
        catch {
            print("Error initializing database: \(error)")
        }
        CBLManager.enableLogging("SyncVerbose")
        installViews()
    }
    
    func installViews() {
        
        let recentJobs = database?.viewNamed("recentJobs")
        
        recentJobs?.setMapBlock(
            {
                (doc, emit) in
                /*if let dateObj: AnyObject = doc["created_at"] {
                    if let date = dateObj as? String {
                        emit(date, doc)
                    }
                }*/
                if let docType: AnyObject = doc["type"] {
                    if docType as! String == "job" {
                        emit(doc["_id"]!, doc)
                    } else {
                        print("Ignoring doc because type != job.  doc: \(doc)")
                    }
                }
            },
            reduceBlock: nil,
            version: "5"
        )
        
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
        let pull = database?.createPullReplication(DBHelper.serverDbURL)
        if pull == nil {
            throw DBHelperError.ReplicationInitializationError
        }
        pull?.customProperties = ["websocket": false]
        
        let replicators = [push, pull]
        for replicator in replicators {
            replicator?.authenticator = fbAuthenticator
            replicator?.continuous = true
            replicator?.start()
        }
    
    }
    
    func createDeepStyleJob(sourceImage: UIImage, styleImage: UIImage) throws -> DeepStyleJob {
        
        // was getting 413 errors with PNG's, used jpeg with lowest compression possible
        let sourceImageData = UIImageJPEGRepresentation(sourceImage, 0.2)
        let styleImageData = UIImageJPEGRepresentation(styleImage, 0.2)
        
        
        let deepStyleJob:DeepStyleJob = DeepStyleJob(forNewDocumentInDatabase: database!)
        deepStyleJob.state = "READY_TO_PROCESS"
        try deepStyleJob.owner = LoginSession.sharedInstance.getLoggedInUserId()
        deepStyleJob.setValue(DeepStyleJob.docType, ofProperty: "type")
        deepStyleJob.setAttachmentNamed("source_image", withContentType: "image/jpg", content: sourceImageData!)
        deepStyleJob.setAttachmentNamed("style_image", withContentType: "image/jpg", content: styleImageData!)
        try deepStyleJob.save()
        return deepStyleJob
        
    }
    
    // Local Document KV store lookup.
    func lookupLocalDocKV(key: String) -> String? {
        let localDocJson = database?.existingLocalDocumentWithID(key)
        if (localDocJson != nil) {
            if let value = localDocJson!["value"] {
                return (value as! String)
            }
        }
        return nil
    }
    
    // Local Document KV store set
    func setLocalDocKV(key: String, value: String) throws {
        let properties = ["value": value]
        try database?.putLocalDocument(properties, withID: key)
    }
    
    
}

enum DBHelperError: ErrorType {
    case FBUserNotLoggedIn
    case ReplicationInitializationError
}