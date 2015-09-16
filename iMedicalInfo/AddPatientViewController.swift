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
    case Contacts = "Contacts"
//    case EmergencyContacts = "Emergency Contacts"
//    case Doctors = "Doctors"
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
    
    var birthdate:NSDate = NSDate()
    
    var mode: AppViewControllerMode = AppViewControllerMode.Edit
    
    @IBAction func cancelAddPatient(){
        
        self.patient?.MR_deleteEntity()
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    
    
    
    @IBAction func confirmAddPatient(){
        
        var firstName:String? = (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 1)) as! AddPatientTextFieldCell).messageTextField?.text
        var lastName:String? = (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 1)) as! AddPatientTextFieldCell).messageTextField?.text
        var dateOfBirth:String? = (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 1)) as! AddPatientTextFieldCell).messageTextField?.text
        var address:String? = (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 1)) as! AddPatientTextFieldCell).messageTextField?.text

        if (self.checkFields() == true){
        
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })

        }
    }
    
    var demographySection:Array<Array<String>> = [[]]
    var healthCardsSection:Array<Array<String>> = [[]]
    var contactsSection:Array<Array<String>> = [[]]
    
    var photoProfileSection:Array<Array<String>> = [
        ["AddPatientPhotoCellIdentifier", "Photo", CellType.PhotoCell.rawValue]
    ]
    
    let sections = [SectionType.PhotoProfile, SectionType.Demographics, SectionType.MyHealthCard, SectionType.Contacts]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.mode == AppViewControllerMode.Edit {
            self.demographySection = [
            ["AddPatientTextFieldCellIdentifier","First Name", CellType.TextFieldCell.rawValue, "", ""],
            ["AddPatientTextFieldCellIdentifier","Last Name", CellType.TextFieldCell.rawValue, "", ""],
            ["AddPatientTextFieldCellIdentifier","Date Of Birth", CellType.TextFieldCell.rawValue, "", ""],
            ["AddPatientTextFieldCellIdentifier","Address", CellType.TextFieldCell.rawValue, "", ""],
            ["AddPatientLabelCellIdentifier","Phones", CellType.LabelCell.rawValue, "showAddSimpleRecordViewController", RecordType.Phone.rawValue],
            ["AddPatientLabelCellIdentifier","Fax Numbers", CellType.LabelCell.rawValue, "showAddSimpleRecordViewController", RecordType.Fax.rawValue],
            ["AddPatientLabelCellIdentifier","Emails", CellType.LabelCell.rawValue, "showAddSimpleRecordViewController", RecordType.Email.rawValue]
                ]
            
            self.healthCardsSection = [
                ["AddPatientLabelCellIdentifier", "Health Insurance", CellType.LabelCell.rawValue, "showAddPhotoInsuranceViewController"],
                ["AddPatientLabelCellIdentifier", "Medications Insurance", CellType.LabelCell.rawValue, "showAddPhotoInsuranceViewController"],
                ["AddPatientLabelCellIdentifier", "Payment Card", CellType.LabelCell.rawValue, "showAddPhotoInsuranceViewController"]]
            self.contactsSection = [
                ["AddPatientLabelCellIdentifier","Emergencies", CellType.LabelCell.rawValue],
                ["AddPatientLabelCellIdentifier","Doctors", CellType.LabelCell.rawValue]]
            
            
        } else if self.mode == AppViewControllerMode.Preview {
            self.demographySection = [
                ["AddPatientLabelPreviewCellIdentifier",self.patient!.demography.firstName, CellType.LabelPreviewCell.rawValue],
                ["AddPatientLabelPreviewCellIdentifier",self.patient!.demography.lastName, CellType.LabelPreviewCell.rawValue],
                ["AddPatientLabelPreviewCellIdentifier",self.patient!.demography.faxNumber, CellType.LabelPreviewCell.rawValue],
                ["AddPatientLabelPreviewCellIdentifier",self.patient!.demography.address, CellType.LabelPreviewCell.rawValue],
                ["AddPatientLabelCellIdentifier","Phones", CellType.LabelCell.rawValue],
                ["AddPatientLabelCellIdentifier","Fax Numbers", CellType.LabelCell.rawValue],
                ["AddPatientLabelCellIdentifier","Emails", CellType.LabelCell.rawValue]]
            self.contactsSection = [
                ["AddPatientLabelCellIdentifier","Emergencies", CellType.LabelCell.rawValue],
                ["AddPatientLabelCellIdentifier","Doctors", CellType.LabelCell.rawValue]]
        }
        
        
    }
    
    
    func checkFields() -> Bool{
        
        if (self.patient?.demography.firstName == nil){
            self.showAlert("Please input first name field")
            return true
        }
        
        if (self.patient?.demography.lastName == nil){
            self.showAlert("Please input last name field")
            return true
        }
        
        if (self.patient?.demography.birthdate == nil){
            self.showAlert("Please input birthdate number  field")
            return true
        }
        
        if (self.patient?.demography.address == nil){
            self.showAlert("Please input address field")
            return true
        }
        
        return false
    }
    
    func showAlert(message:String){
        var alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        self.showViewController(alert, sender: self)
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
            return self.healthCardsSection.count
        case .Contacts:
            return self.contactsSection.count
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
            currentData = self.healthCardsSection
        case .Contacts:
            currentData = self.contactsSection
        default:
            break
            
        }
        
        var currentIndexData:Array! = currentData!.objectAtIndex(indexPath.row) as! Array<String>
        
        let identifier:String = currentIndexData[0]
        
        
        if identifier == CellType.TextFieldCell.rawValue {
            let cell:AddPatientTextFieldCell! = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! AddPatientTextFieldCell
            cell.messageTextField?.placeholder = currentIndexData[1]
            
            if (indexPath == NSIndexPath(forRow: 2, inSection: 1)){
                
                cell.messageTextField!.text = DatePickerView.dateToString(self.birthdate)
                
                var myPicker:DatePickerView = NSBundle.mainBundle().loadNibNamed("DatePickerView", owner: self, options: nil).first as! DatePickerView
                
                cell.messageTextField?.inputView = myPicker
                
                myPicker.callbackDatePickerView = {
                    self.updateTextField(myPicker.datePicker)
                    cell.messageTextField?.resignFirstResponder()
                    cell.messageTextField?.text = DatePickerView.dateToString(myPicker.datePicker.date)
                }
            }
            
            
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
    
    func updateTextField(sender:UIDatePicker){
        self.birthdate = sender.date
        
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
            currentData = self.healthCardsSection
        case .Contacts:
            currentData = self.contactsSection
        default:
            break
            
        }
        var currentIndexData:Array! = currentData!.objectAtIndex(indexPath.row) as! Array<String>

        var segueMessage:String = currentIndexData[3]
        
        if !segueMessage.isEmpty {
            self.performSegueWithIdentifier(segueMessage, sender: currentIndexData)
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showAddSimpleRecordViewController" {
            
            var currentIndexData:Array<String>! = sender as! Array<String>
            var controller:AddSimpleRecordViewController = segue.destinationViewController as! AddSimpleRecordViewController
            controller.title = currentIndexData[1]
            controller.type = RecordType(rawValue: currentIndexData[4])!
            
        }
        
        if segue.identifier == "showAddPhotoInsuranceViewController" {
            
            var currentIndexData:Array<String>! = sender as! Array<String>
            var controller:AddPhotoInsuranceViewController = segue.destinationViewController as! AddPhotoInsuranceViewController
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
            currentData = self.healthCardsSection
        case .Contacts:
            currentData = self.contactsSection
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

}
