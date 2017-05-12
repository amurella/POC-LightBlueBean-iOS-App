//
//  IDViewController.swift
//  BeanDemoConnection
//
//  Created by Akhila Murella on 5/11/17.
//  Copyright © 2017 Akhila Murella. All rights reserved.
//

import UIKit

class IDViewController: UIViewController {

    @IBOutlet weak var userID: UITextField!
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
       // let date = NSDate()
      //  let calender = NSCalendar.current
      //  let components = calender.components([.Hour, .Minute], fromDate: date)
        
        let currentDateTime = Date()
        
        // initialize the date formatter and set the style
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        
        // get the date time String from the date object
        let result = formatter.string(from: currentDateTime) // October 8, 2016 at 10:48:53 PM

    
        dateAndTimeLabel.text = result
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "idSegue"
        {
                let controller = segue.destination as! ViewController
                controller.userID = userID.text!
                controller.dateString = dateAndTimeLabel.text!
                print(dateAndTimeLabel.text)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
