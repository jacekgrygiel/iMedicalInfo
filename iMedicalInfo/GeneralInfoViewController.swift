//
//  FirstViewController.swift
//  iMedicalInfo
//
//  Created by Jacek Grygiel on 10/07/15.
//  Copyright (c) 2015 Product. All rights reserved.
//

import UIKit
import MobileCoreServices

class AddPatientColllectionCell:UICollectionViewCell {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5.0
    }
    
}

class PatientColllectionCell:UICollectionViewCell {
    
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet weak var patientName:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 5.0
    }
    
}


class GeneralInfoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var collectionView:UICollectionView!
    var controller: UIImagePickerController?
    
    var selectedPatient:Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    func patients() -> NSArray? {
        
        var patientstemp:NSArray? = Patient.MR_findAll()
        if patientstemp == nil {
            patientstemp = NSArray()
        }
        return patientstemp
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.collectionView.reloadData()
    }
    
    func createNewPatient(image:UIImage?){
        
        if image != nil {
            
            //let context = NSManagedObjectContext.MR_contextWithParent(NSManagedObjectContext.MR_context())

            var patient:Patient = Patient.MR_createEntity()
            patient.photo = UIImageJPEGRepresentation(image, 0.1)
            patient.patientName = "Unknown name"
            self.selectedPatient = patient
            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()

            
            var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("showAddPatientAction"), userInfo: nil, repeats: false)


    
        }
    }
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == self.patients()?.count {
            
            PhotoManager.sharedInstance.takePhoto(true, mainController: self, callback: { (image) -> Void in
                self.createNewPatient(image)
            })
            
        } else{
            self.showAddPatientAction(false)
        }
        
    }
    

    
    func showAddPatientAction(){
        self.performSegueWithIdentifier("showAddPatient", sender: true);
    }
    
    func showAddPatientAction(var edit:Bool){
        self.performSegueWithIdentifier("showAddPatient", sender: edit);
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showAddPatient" {
            
            var nav:UINavigationController = segue.destinationViewController as! UINavigationController
            var contr:AddPatientViewController = nav.viewControllers.first as! AddPatientViewController
            if (sender as! Bool) == false {
                contr.mode = AppViewControllerMode.Preview
            }
            contr.patient = self.selectedPatient
            
        }
    }

}

extension GeneralInfoViewController:UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.patients() != nil{
        return self.patients()!.count + 1
        } else {
            return 1
        }
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        NSLog("%@", indexPath)
        NSLog("%@", self.patients()!)
        
        if indexPath.row == self.patients()!.count {
            var cell:AddPatientColllectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("AddPatientCellIdentifier", forIndexPath: indexPath) as! AddPatientColllectionCell
            return cell
        } else{
            var cell:PatientColllectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("PatientCellIdentifier", forIndexPath: indexPath) as! PatientColllectionCell
            var patient:Patient = self.patients()?[indexPath.row] as! Patient
            cell.imageView.image = UIImage(data: patient.photo)
           // cell.patientName.text = "\(patient.demography.firstName) \(patient.demography.lastName)"
            
            return cell
        }
        
    }
    
    
    
    
    
    
}
