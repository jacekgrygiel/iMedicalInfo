//
//  AddPhoneViewController.swift
//  iMedicalInfo
//
//  Created by Jacek Grygiel on 26.07.2015.
//  Copyright (c) 2015 Product. All rights reserved.
//

import UIKit
class EditableCell:MCSwipeTableViewCell {
    
    @IBOutlet weak var messageTextField:UITextField?
    
}

class PreviewCell:MCSwipeTableViewCell {
    
    @IBOutlet weak var messageLabel:UILabel?
    
}


enum RecordType : String {
    
    case Fax = "Fax"
    case Phone = "Phone"
    case Email = "Email"
    case Default = "Default"
}


class AddSimpleRecordViewController: UITableViewController {

    var records:NSMutableArray = NSMutableArray()
    
    var mode:AppViewControllerMode = AppViewControllerMode.Edit
    var type:RecordType = RecordType.Default
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func addNewRecord(sender: AnyObject) {
        
        
        weak var selfWeak:AddSimpleRecordViewController? = self

        var titleText:String?
        switch type {
        case .Fax:
            titleText = "Add Fax"
        case .Email:
            titleText = "Add Email"
        case .Phone:
            titleText = "Add Phone"
        case .Default:
            titleText = "Add New Record"
        }
        
        var alertText:UIAlertController = UIAlertController(title: titleText!, message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alertText.addTextFieldWithConfigurationHandler { (textField) -> Void in
            
            
            switch self.type {
            case .Fax:
                textField.keyboardType = UIKeyboardType.PhonePad
            case .Email:
                textField.keyboardType = UIKeyboardType.EmailAddress
            case .Phone:
                textField.keyboardType = UIKeyboardType.PhonePad
            case .Default:
                titleText = "Add New Record"
            }
            
        }
        alertText.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void  in
            
            var current:UITextField =  alertText.textFields?.first as! UITextField
            selfWeak?.records.addObject(current.text);
            selfWeak?.tableView.reloadData()
            
        }))
        alertText.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Destructive, handler: { (alertAction) -> Void in
            
        }))
        
        self.showDetailViewController(alertText, sender: self)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.records.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if self.mode == AppViewControllerMode.Edit {
            
            let cell:EditableCell = tableView.dequeueReusableCellWithIdentifier("EditableCellIdentifier", forIndexPath: indexPath) as! EditableCell
            
            cell.messageTextField?.text = self.records.objectAtIndex(indexPath.row) as! String
            cell.selectionStyle = UITableViewCellSelectionStyle.Gray
            cell.contentView.backgroundColor = UIColor.whiteColor()
            
            switch self.type {
            case .Fax:
                cell.messageTextField!.keyboardType = UIKeyboardType.PhonePad
            case .Email:
                cell.messageTextField!.keyboardType = UIKeyboardType.EmailAddress
            case .Phone:
                cell.messageTextField!.keyboardType = UIKeyboardType.PhonePad
            case .Default:
                cell.messageTextField!.keyboardType = UIKeyboardType.Default

            }
            
            
            var swipeView1:UIImageView = UIImageView(image: UIImage(named: "cell_remove_btn"))
            swipeView1.frame = CGRectMake(0, 0, cell.frame.height/2, cell.frame.height/2)
            
            var swipeView2:UIImageView = UIImageView(image: UIImage(named: "cell_call_btn"))
            swipeView2.frame = CGRectMake(0, 0, cell.frame.height/2, cell.frame.height/2)
            
            weak var selfWeak:AddSimpleRecordViewController? = self
            
            cell.setSwipeGestureWithView(swipeView1, color: UIColor.medicalColor1(), mode: MCSwipeTableViewCellMode.Switch, state: MCSwipeTableViewCellState.State1) { (cell, state, mode) -> Void in
                
                var index = selfWeak?.tableView.indexPathForCell(cell)?.row
                if index != nil {
                    selfWeak?.records.removeObjectAtIndex(index!)
                }
                selfWeak?.tableView.reloadData()
            }
            
            cell.setSwipeGestureWithView(swipeView2, color: UIColor.medicalColor2(), mode: MCSwipeTableViewCellMode.Switch, state: MCSwipeTableViewCellState.State3) { (cell, state, mode) -> Void in
                
            }
            
            return cell;
        }else{
            
            let cell:PreviewCell = tableView.dequeueReusableCellWithIdentifier("PreviewCellIdentifier", forIndexPath: indexPath) as! PreviewCell
            return cell;
        }
    }


}
