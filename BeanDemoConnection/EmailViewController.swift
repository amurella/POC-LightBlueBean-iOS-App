//
//  EmailViewController.swift
//  BeanDemoConnection
//
//  Created by Akhila Murella on 4/20/17.
//  Copyright © 2017 Akhila Murella. All rights reserved.
//

import UIKit
import MessageUI
class EmailViewController: UIViewController, MFMailComposeViewControllerDelegate {

    
    var csvText : String = " "
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exportCSV(_ sender: Any)
    {
      
        
        let fileName = "TimeData.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        
        
        do
        {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        }
        catch
        {
            print("Failed to export file")
        }
        
        let emailViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail()
        {
            self.present(emailViewController, animated: true, completion: nil)
        }
        
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController
    {
        let emailController = MFMailComposeViewController()
        emailController.mailComposeDelegate = self
        emailController.setSubject("CSV File")
        emailController.setMessageBody("Here is the data", isHTML: false)
        
        let data = csvText.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        emailController.addAttachmentData(data, mimeType: "text/csv", fileName: "TimeData.csv")
        return emailController
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
