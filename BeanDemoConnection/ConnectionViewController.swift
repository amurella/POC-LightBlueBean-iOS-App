//
//  ConnectionViewController.swift
//  BeanDemoConnection
//
//  Created by Akhila Murella on 5/21/17.
//  Copyright © 2017 Akhila Murella. All rights reserved.
//

import UIKit
import Bean_iOS_OSX_SDK
import CoreBluetooth

class ConnectionViewController: UIViewController, PTDBeanManagerDelegate, PTDBeanDelegate
{
        var beanManager: PTDBeanManager!
        var myBean: PTDBean!
        
    @IBOutlet weak var connectionLabel: UILabel!

    @IBOutlet weak var beanNameChanged: UILabel!

        
        override func didReceiveMemoryWarning()
        {
            super.didReceiveMemoryWarning()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            beanManager = PTDBeanManager()
            beanManager!.delegate = self
        }
    
   /* override func viewDidAppear(_ animated: Bool)
    {
        if(self.myBean != nil)
        {
            beanManager.disconnectBean(myBean, error: nil)
            self.myBean = nil
        }
        
        var error: NSError?
        beanManager!.startScanning(forBeans_error: &error)
        if let e = error
        {
            print(e)
        }
        else
        {
            print("Connection is made")
        }
    }*/
    
    
    func beanManagerDidUpdateState(_ beanManager: PTDBeanManager!)
        {
            let scanError: NSError?
            if beanManager!.state == BeanManagerState.poweredOn
            {
                print("made it here")
                startScanning()
                print("made it here part 2")
            }
        }
    
    func startScanning()
    {
        var error: NSError?
        beanManager!.startScanning(forBeans_error: &error)
        if let e = error
        {
            print(e)
        }
        else
        {
            print("Connection is made")
        }
    }
        
    @IBAction func connectToBean(_ sender: Any)
    {
        beanManager!.connect(to: myBean, withOptions:nil, error: nil)
        myBean.delegate = self
        connectionLabel.text = "You are now connected"
    }
    
        func beanManager(_ beanManager: PTDBeanManager!, didDiscover bean: PTDBean!, error: Error!)
        {
            if myBean == nil
            {
                if bean.state == .discovered
                {
                    print("bean discovered")
                    beanNameChanged.text = bean.name
                    //       beanDiscovered = true
                    viewDidAppear(true)
                    myBean = bean
                    //beanManager!.connect(to: bean, withOptions:nil, error: nil)
               //     bean.delegate = self
                }
            }
            
            #if DEBUG
                print("DISCOVERED BEAN \nName: \(bean.name), UUID: \(bean.identifier) RSSI: \(bean.rssi)")
            #endif
        }
        
        
        
        
    
        
    
        
      /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if segue.identifier == "transferToPatientScreen"
            {
                let controller = segue.destination as! IDViewController
                controller.myBean = myBean
            }
        }*/
        

}
