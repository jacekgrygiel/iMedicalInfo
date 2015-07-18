//
//  AddPatientViewController.swift
//  iMedicalInfo
//
//  Created by Jacek Grygiel on 10/07/15.
//  Copyright (c) 2015 Product. All rights reserved.
//

import UIKit

enum SectionType: String {
    case PhotoProfile = "Profile Photo"
    case Demographics = "Demographics"
    case MyHealthCard = "My Health Card"
    case EmergencyContacts = "Emergency Contacts"
    case Doctors = "Doctors"
}

enum CellType: String {
    case PhotoCell = "AddPatientPhotoCellIdentifier"
    case TextFieldCell = "AddPatientTextFieldCellIdentifier"
    case LabelCell = "AddPatientLabelCellIdentifier"
    case LabelPreviewCell = "AddPatientLabelPreviewCellIdentifier"
}

class AddPatientTextFieldCell:UITableViewCell {
    
    @IBOutlet weak var messageTextField:UITextField?

}

class AddPatientPhotoCell:UITableViewCell {
    
    @IBOutlet weak var photoImageView:UIImageView?
    
}

class AddPatientLabelCell:UITableViewCell {
    
    @IBOutlet weak var messageLabel:UILabel?
    
}

class AddPatientPreviewLabelCell:UITableViewCell{
    @IBOutlet weak var messageLabel:UILabel?
}


class AddPatientViewController: UITableViewController {

    var patient:Patient?
    var mode: AppViewControllerMode = AppViewControllerMode.Edit
    
    @IBAction func cancelAddPatient(){
        
        self.patient?.MR_deleteEntity()
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    
    
    
    @IBAction func confirmAddPatient(){
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    var demographySection:Array<Array<String>> = [[]]
    var healthCardsSection:Array<Array<String>> = [[]]
    var emergencyContacts:Array<Array<String>> = [[]]
    
    
    var photoProfileSection:Array<Array<String>> = [
        ["AddPatientPhotoCellIdentifier", "Photo", CellType.PhotoCell.rawValue]
    ]
    
    let sections = [SectionType.PhotoProfile, SectionType.Demographics, SectionType.MyHealthCard, SectionType.EmergencyContacts, SectionType.Doctors]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.mode == AppViewControllerMode.Edit {
            self.demographySection = [
            ["AddPatientTextFieldCellIdentifier","First Name", CellType.TextFieldCell.rawValue],
            ["AddPatientTextFieldCellIdentifier","Last Name", CellType.TextFieldCell.rawValue],
            ["AddPatientTextFieldCellIdentifier","Date Of Birth", CellType.TextFieldCell.rawValue],
            ["AddPatientTextFieldCellIdentifier","Address", CellType.TextFieldCell.rawValue],
            ["AddPatientLabelCellIdentifier","Phones", CellType.LabelCell.rawValue],
            ["AddPatientLabelCellIdentifier","Fax Numbers", CellType.LabelCell.rawValue],
            ["AddPatientLabelCellIdentifier","Emails", CellType.LabelCell.rawValue]]
            self.emergencyContacts = [
                ["AddPatientTextFieldCellIdentifier","First Name", CellType.TextFieldCell.rawValue],
                ["AddPatientTextFieldCellIdentifier","Last Name", CellType.TextFieldCell.rawValue],
                ["AddPatientTextFieldCellIdentifier","Relationship", CellType.TextFieldCell.rawValue],
                ["AddPatientLabelCellIdentifier","Phones", CellType.LabelCell.rawValue]]
            
        } else if self.mode == AppViewControllerMode.Preview {
            self.demographySection = [
                ["AddPatientLabelPreviewCellIdentifier",self.patient!.demography.firstName, CellType.LabelPreviewCell.rawValue],
                ["AddPatientLabelPreviewCellIdentifier",self.patient!.demography.lastName, CellType.LabelPreviewCell.rawValue],
                ["AddPatientLabelPreviewCellIdentifier",self.patient!.demography.firstName, CellType.LabelPreviewCell.rawValue],
                ["AddPatientLabelPreviewCellIdentifier",self.patient!.demography.address, CellType.LabelPreviewCell.rawValue],
                ["AddPatientLabelCellIdentifier","Phones", CellType.LabelCell.rawValue],
                ["AddPatientLabelCellIdentifier","Fax Numbers", CellType.LabelCell.rawValue],
                ["AddPatientLabelCellIdentifier","Emails", CellType.LabelCell.rawValue]]
            self.emergencyContacts = [
                ["AddPatientLabelPreviewCellIdentifier",self.patient!.emergencyContacts.firstName, CellType.LabelPreviewCell.rawValue],
                ["AddPatientLabelPreviewCellIdentifier",self.patient!.emergencyContacts.lastName, CellType.LabelPreviewCell.rawValue],
                ["AddPatientTextFieldCellIdentifier",self.patient!.emergencyContacts.relationship, CellType.TextFieldCell.rawValue],
                ["AddPatientLabelCellIdentifier","Phones", CellType.LabelCell.rawValue]]
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return sections.count;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        var type:SectionType = self.sections[section]
        switch type {
        case .PhotoProfile:
            return self.photoProfileSection.count
        case .Demographics:
            return self.demographySection.count
        case .MyHealthCard:
            return self.demographySection.count
        case .EmergencyContacts:
            return self.emergencyContacts.count
        case .Doctors:
            return self.demographySection.count
        default:
            break
            
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var type:SectionType = self.sections[indexPath.section]
        var currentData:NSArray?
        
        switch type {
        case .PhotoProfile:
            currentData = self.photoProfileSection
        case .Demographics:
            currentData = self.demographySection
        case .MyHealthCard:
            currentData = self.demographySection
        case .EmergencyContacts:
            currentData = self.emergencyContacts
        case .Doctors:
            currentData = self.demographySection
        default:
            break
            
        }
        
        var currentIndexData:Array! = currentData!.objectAtIndex(indexPath.row) as! Array<String>
        
        let identifier:String = currentIndexData[0]
        
        
        if identifier == CellType.TextFieldCell.rawValue {
            let cell:AddPatientTextFieldCell! = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! AddPatientTextFieldCell
            cell.messageTextField?.placeholder = currentIndexData[1]
            return cell
        }else if identifier == CellType.LabelCell.rawValue{
            let cell:AddPatientLabelCell! = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! AddPatientLabelCell
            cell.messageLabel?.text = currentIndexData[1]
            return cell
        }else if identifier == CellType.PhotoCell.rawValue{
            let cell:AddPatientPhotoCell! = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! AddPatientPhotoCell
            var image:UIImage = UIImage(data: self.patient!.photo, scale: 0.5)!
            cell.photoImageView?.image = image
            return cell
        }else if identifier == CellType.LabelPreviewCell.rawValue {
            let cell:AddPatientPreviewLabelCell! = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! AddPatientPreviewLabelCell
            cell.messageLabel?.text = currentIndexData[1]
            
        }
        
        let cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! UITableViewCell
        return cell
    }


    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section].rawValue
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var type:SectionType = self.sections[indexPath.section]
        var currentData:NSArray?
        
        switch type {
        case .PhotoProfile:
            currentData = self.photoProfileSection
        case .Demographics:
            currentData = self.demographySection
        case .MyHealthCard:
            currentData = self.demographySection
        case .EmergencyContacts:
            currentData = self.demographySection
        case .Doctors:
            currentData = self.demographySection
        default:
            break
            
        }
        var currentIndexData:Array! = currentData!.objectAtIndex(indexPath.row) as! Array<String>

        if currentIndexData[2] == CellType.LabelCell.rawValue {
            
            self.performSegueWithIdentifier("showAddListViewController", sender: currentIndexData)
            
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showAddListViewController" {
            
            var currentIndexData:Array<String>! = sender as! Array<String>
            var controller:AddListViewController = segue.destinationViewController as! AddListViewController
            controller.title = currentIndexData[1]
            
        }
        
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var type:SectionType = self.sections[indexPath.section]
        var currentData:NSArray?
        
        switch type {
        case .PhotoProfile:
            currentData = self.photoProfileSection
        case .Demographics:
            currentData = self.demographySection
        case .MyHealthCard:
            currentData = self.demographySection
        case .EmergencyContacts:
            currentData = self.demographySection
        case .Doctors:
            currentData = self.demographySection
        default:
            break
            
        }
        
        var currentIndexData:Array! = currentData!.objectAtIndex(indexPath.row) as! Array<String>
        
        let identifier:String = currentIndexData[0]
        
        if identifier == CellType.TextFieldCell.rawValue {
            return 50.0
        }else if identifier == CellType.LabelCell.rawValue{
            return 50.0
        }else if identifier == CellType.PhotoCell.rawValue{
            return 140
        }else if identifier == CellType.LabelPreviewCell.rawValue{
            return 50.0
        }
        
        return 50.0
    
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
