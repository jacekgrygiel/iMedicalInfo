//
//  DatePickerView.swift
//  iMedicalInfo
//
//  Created by Jacek Grygiel on 08/09/15.
//  Copyright (c) 2015 Product. All rights reserved.
//

import UIKit

class DatePickerView: UIView {

    
    var callbackDatePickerView: (Void) -> (Void) = { () -> Void in
        
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        
        if self.callbackDatePickerView != nil {
            self.callbackDatePickerView()
        }
    }

    @IBOutlet weak var datePicker: UIDatePicker!

    class func dateToString(date:NSDate) -> String{
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        var string =  dateFormatter.stringFromDate(date)
        return string
    }
    
    
}
