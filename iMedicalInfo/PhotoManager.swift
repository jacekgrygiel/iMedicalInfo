//
//  PhotoManager.swift
//  iMedicalInfo
//
//  Created by Jacek Grygiel on 03/08/15.
//  Copyright (c) 2015 Product. All rights reserved.
//

import UIKit
import MobileCoreServices

class PhotoManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
   
    static let sharedInstance = PhotoManager()
    var controller: UIImagePickerController?
    var callbackPhoto: (UIImage) -> (Void) = { (image) -> Void in
        
    }

    
    
    override init() {
        super.init()
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        print("Picker returned successfully")
        
        let mediaType:AnyObject? = info[UIImagePickerControllerMediaType]
        
        if let type:AnyObject = mediaType{
            
            if type is String{
                let stringType = type as! String
                
                if stringType == kUTTypeMovie as String{
                    let urlOfVideo = info[UIImagePickerControllerMediaURL] as? NSURL
                    if let url = urlOfVideo{
                    }
                }
                    
                else if stringType == kUTTypeImage as String{
                    
                    /* Let's get the metadata. This is only for images. Not videos */
                    let metadata = info[UIImagePickerControllerMediaMetadata]
                        as? NSDictionary
                    if let theMetaData = metadata{
                        let image:UIImage = info[UIImagePickerControllerOriginalImage]
                            as! UIImage
                        
                            self.callbackPhoto(image)
                        
                    }
                }
                
            }
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    
    
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
    func cameraSupportsMedia(mediaType: String,
        sourceType: UIImagePickerControllerSourceType) -> Bool{
            
            let availableMediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType)
            
            if let types = availableMediaTypes{
                for type in types{
                    if (type as! String) == mediaType{
                        return true
                    }
                }
            }
            
            return false
    }
    
    func doesCameraSupportTakingPhotos() -> Bool{
        return cameraSupportsMedia(kUTTypeImage as String, sourceType: .Camera)
    }
    
    func takePhoto(animated: Bool, mainController:UIViewController, callback: (UIImage) -> Void ) {
        
        self.callbackPhoto = callback
        
        if isCameraAvailable() && doesCameraSupportTakingPhotos(){
            
            controller = UIImagePickerController()
            
            if let theController = controller{
                theController.sourceType = .Camera
                
                theController.mediaTypes = [kUTTypeImage as String]
                
                theController.allowsEditing = true
                theController.delegate = self
                
                mainController.presentViewController(theController, animated: true, completion: nil)
            }
            
        } else {
            print("Camera is not available")
            let image = UIImage(named: "patient2")
            self.callbackPhoto(image!)
        }
        
    }
    
}
