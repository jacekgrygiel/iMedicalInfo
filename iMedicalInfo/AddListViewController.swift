//
//  AddListViewController.swift
//  iMedicalInfo
//
//  Created by Jacek Grygiel on 10/07/15.
//  Copyright (c) 2015 Product. All rights reserved.
//

import UIKit


class EditableCell:MCSwipeTableViewCell {
    
    @IBOutlet weak var messageTextField:UITextField?
    
}

class PreviewCell:MCSwipeTableViewCell {
    
    @IBOutlet weak var messageLabel:UILabel?
    
}




class AddListViewController: UITableViewController {

    var records:NSMutableArray = NSMutableArray()

    var mode:AppViewControllerMode = AppViewControllerMode.Edit;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    @IBAction func addNewRecord(sender: AnyObject) {


        weak var selfWeak:AddListViewController? = self
        
        var alertText:UIAlertController = UIAlertController(title: "Add New Record", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alertText.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Type ...."
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

            var swipeView1:UIImageView = UIImageView(image: UIImage(named: "cell_remove_btn"))
            swipeView1.frame = CGRectMake(0, 0, cell.frame.height/2, cell.frame.height/2)
            
            var swipeView2:UIImageView = UIImageView(image: UIImage(named: "cell_call_btn"))
            swipeView2.frame = CGRectMake(0, 0, cell.frame.height/2, cell.frame.height/2)
            
            weak var selfWeak:AddListViewController? = self

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
            cell.messageLabel?.text = self.records.objectAtIndex(indexPath.row) as! String
            return cell;
        }
    }


}
