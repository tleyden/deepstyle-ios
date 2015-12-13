//
//  AddDeepStyleViewController.swift
//  DeepStyle
//
//  Created by Traun Leyden on 12/12/15.
//  Copyright © 2015 DeepStyle. All rights reserved.
//

import UIKit

// TODO: when button tapped, let user choose an image

class AddDeepStyleViewController: UIViewController {

    var presenterViewController: PresenterViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancel:")
        self.navigationItem.leftBarButtonItem = cancelButton;
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "done:")
        self.navigationItem.rightBarButtonItem = doneButton;
    }

    func cancel(sender: UIBarButtonItem) {
        presenterViewController?.dismiss()
    }
    
    func done(sender: UIBarButtonItem) {
        
        // TODO: callback PhotoReceiverDelegate with the images
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
