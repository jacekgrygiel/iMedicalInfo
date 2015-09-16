//
//  AddPhotoInsuranceViewController.swift
//  
//
//  Created by Jacek Grygiel on 03/08/15.
//
//

import UIKit

class AddPhotoInsuranceViewController: UITableViewController {

    @IBOutlet weak var frontPhotoCoverImage: UIImageView!
    @IBOutlet weak var backCoverPhotoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            PhotoManager.sharedInstance.takePhoto(true, mainController: self, callback: { (image) -> Void in
                self.frontPhotoCoverImage.image = image
            })
        }else{
            PhotoManager.sharedInstance.takePhoto(true, mainController: self, callback: { (image) -> Void in
                self.backCoverPhotoImage.image = image
            })
        }
    }

}
