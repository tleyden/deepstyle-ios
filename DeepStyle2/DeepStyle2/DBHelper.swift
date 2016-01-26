

import UIKit
import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import CRToast


// All database access should go through this class

class DBHelper {
    
    // The local DB name
    static let databaseName = "deepstyle"
    
    // The remote database URL to sync with.
    static let serverDbURL = NSURL(string: "http://demo.couchbasemobile.com:4984/deepstyle/")!
    
    // SG 1.2 CC
    // static let serverDbURL = NSURL(string: "http://ec2-54-145-244-2.compute-1.amazonaws.com:4985/deepstyle-cc/")!
    
    // SG 1.2 DI
    // static let serverDbURL = NSURL(string: "http://ec2-54-145-244-2.compute-1.amazonaws.com:4985/deepstyle-di/")!
    
    // SG 1.1
    // static let serverDbURL = NSURL(string: "http://ec2-54-161-209-25.compute-1.amazonaws.com:4985/deepstyle-cc-sg-11/")!
    
    static let sharedInstance = DBHelper()
    
    var database: CBLDatabase? = nil
    
    var lastReplicationError: NSError?
    
    init() {
        do {
            
            CBLManager.sharedInstance().storageType = kCBLForestDBStorage
            
            // new replicator -- not working
            // dbmgr.replicatorClassName = @"CBLBlipReplicator";
            // dbmgr.dispatchQueue = dispatch_get_main_queue();
            
            try database = CBLManager.sharedInstance().databaseNamed(DBHelper.databaseName)
            
            print("Manager directory \(CBLManager.sharedInstance().directory)")
            
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
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "replicationProgress:",
            name: kCBLReplicationChangeNotification,
            object: push
        )
        
        let replicators = [push, pull]
        for replicator in replicators {
            replicator?.authenticator = fbAuthenticator
            replicator?.continuous = true
            replicator?.start()
        }
    
    }
    
    @objc func replicationProgress(n: NSNotification) {
        
        if n.object == nil {
            return
        }
        
        let replication = n.object as! CBLReplication
        
        if (replication.lastError != nil) {
            
            print("Replication \(replication) got an error: \(replication.lastError)")
            
            var direction = "Upload"
            if replication.pull {
                direction = "Download"
            }
            let errorText = "Cloud \(direction) Error 😖"

            let options: NSDictionary = [
                kCRToastTextKey : errorText,
                kCRToastTextAlignmentKey : NSTextAlignment.Center.rawValue,
                kCRToastBackgroundColorKey : UIColor.redColor(),
                kCRToastAnimationInTypeKey : CRToastAnimationType.Gravity.rawValue,
                kCRToastAnimationOutTypeKey : CRToastAnimationType.Gravity.rawValue,
                kCRToastAnimationInDirectionKey : CRToastAnimationDirection.Top.rawValue,
                kCRToastAnimationOutDirectionKey : CRToastAnimationDirection.Top.rawValue,
                kCRToastTimeIntervalKey: NSTimeInterval(5.0),
            ]
            CRToastManager.showNotificationWithOptions(options as [NSObject : AnyObject], apperanceBlock: { () -> Void in
                    print("notification appeared")
                }, completionBlock: { () -> Void in
                    print("notification done")
            })
            
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