//
//  AddDeepStyleViewController.swift
//  DeepStyle
//
//  Created by Traun Leyden on 12/12/15.
//  Copyright © 2015 DeepStyle. All rights reserved.
//

import UIKit

// TODO: when button tapped, let user choose an image

class AddDeepStyleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var presenterViewController: PresenterViewController? = nil
    var photoImage: UIImage? = nil
    var paintingImage: UIImage? = nil
    @IBOutlet var choosePhotoButton: UIButton? = nil
    @IBOutlet var choosePaintingButton: UIButton? = nil

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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("imagePickerController didFinishPickingMediaWithInfo")
        print(info)
        print(picker.view.tag)
        if picker.view.tag == 0 {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.photoImage = image
            }
        } else {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.paintingImage = image
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func doPick (sender:AnyObject!) {
        
        // horrible
        // let src = UIImagePickerControllerSourceType.SavedPhotosAlbum
        let src = UIImagePickerControllerSourceType.PhotoLibrary
        let ok = UIImagePickerController.isSourceTypeAvailable(src)
        if !ok {
            print("alas")
            return
        }
        
        let arr = UIImagePickerController.availableMediaTypesForSourceType(src)
        if arr == nil {
            print("no available types")
            return
        }
        let picker = UIImagePickerController() // see comments below for reason
        picker.sourceType = src
        picker.mediaTypes = arr!
        picker.delegate = self
        if sender as? UIButton == choosePhotoButton! {
            picker.view.tag = 0
        } else if sender as? UIButton == choosePaintingButton! {
            picker.view.tag = 1
        }
        
        picker.allowsEditing = false // try true
        
        // this will automatically be fullscreen on phone and pad, looks fine
        // note that for .PhotoLibrary, iPhone app must permit portrait orientation
        // if we want a popover, on pad, we can do that; just uncomment next line
        // picker.modalPresentationStyle = .Popover
        self.presentViewController(picker, animated: true, completion: nil)
        // ignore:
        if let pop = picker.popoverPresentationController {
            let v = sender as! UIView
            pop.sourceView = v
            pop.sourceRect = v.bounds
        }
        
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
