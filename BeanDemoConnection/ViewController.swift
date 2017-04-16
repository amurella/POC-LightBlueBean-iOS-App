//
//  ViewController.swift
//  BeanDemoConnection
//
//  Created by Akhila Murella on 4/15/17.
//  Copyright © 2017 Akhila Murella. All rights reserved.
//

import UIKit
import Bean_iOS_OSX_SDK

class ViewController: UIViewController, PTDBeanManagerDelegate, PTDBeanDelegate {

    @IBOutlet weak var ledTextLabel: UILabel!
    var beanManager: PTDBeanManager!
    var myBean: PTDBean!
    var lightState: Bool = false
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beanManager = PTDBeanManager()
        beanManager!.delegate = self
    }
    
    /*override func viewDidAppear(_ animated: Bool)
    {
        // super.viewDidAppear(true)
        /* let controller = UIAlertController(title: "Bluetooth Connection is in process", message: "This app requires a Bluetooth Connection", preferredStyle: .alert)
         present(controller, animated:true, completion: nil)*/
        startScanning()
        
        
        /* dismissAlertClosure =
         //            {
         self.dismiss(animated: true, completion: nil)
         let controller = UIAlertController(title: "Bluetooth Connection is successful!", message: "This app has created a Bluetooth Connection", preferredStyle: .alert)
         present(controller, animated:true, completion: nil)
         }*/
        
        //      var endTime: dispatch_time_t = DispatchTime.now(dispatch_time_t(DISPATCH_TIME_NOW), Int64(5.0 * Double(NSEC_PER_SEC)))
        //   dispatch_after(endTime, DispatchQueue.main, {self.beanDiscovered = true})
    }*/
    
    /*    func checkConnectionAnimation()
     {
     while(beanDiscovered == false)
     {
     
     }
     
     if(beanDiscovered == true)
     {
     
     self.dismiss(animated: true, completion: nil)
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
            
            /*if let e = scanError
             {
             print(e)
             }
             else
             {
             print("Please turn on your Bluetooth")
             }*/
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
    
    /* func beanManager(_ beanManager: PTDBeanManager!, didDiscover bean: PTDBean!, error: Error!) {
     print ("HELLO")
     if let e = error
     {
     print(e)
     }
     print("Found a bean: \(bean.name)")
     if myBean == nil
     {
     if bean.state == .discovered
     {
     if bean.name == "Bean"
     {
     myBean = bean
     print("discovered to the bean")
     connectToBean(bean: myBean!)
     print("connected to the bean")
     }
     }
     connectToBean(bean: myBean!)
     }
     }*/
    
    /*func beanManager(_ beanManager: PTDBeanManager!, didDiscover bean: PTDBean!, error: Error!) {
     if let e = error {
     print(e)
     }
     print("Found a Bean: \(bean.name)")
     myBean = bean
     myBean!.delegate = self
     connectToBean(bean: myBean!)
     
     }*/
    
    func beanManager(_ beanManager: PTDBeanManager!, didDiscover bean: PTDBean!, error: Error!) {
        if myBean == nil {
            if bean.state == .discovered {
                print("bean discovered")
                //       beanDiscovered = true
                viewDidAppear(true)
                myBean = bean
                beanManager!.connect(to: bean, withOptions:nil, error: nil)
            }
        }
        
        #if DEBUG
            print("DISCOVERED BEAN \nName: \(bean.name), UUID: \(bean.identifier) RSSI: \(bean.rssi)")
        #endif
    }
    
    /*  func beanManager(_ beanManager: PTDBeanManager!, didDiscover bean: PTDBean!, error: NSError!) {
     print("pls luv me")
     
     
     
     if bean.name == "Bean" {
     
     }
     }*/
    
    /* func beanManager(_ beanManager: PTDBeanManager!, didConnect bean: PTDBean!, error: Error!) {
     if myBean == nil
     {
     myBean = bean
     print("Officially connected")
     }
     }*/
    
    //to receive bean code
    /*  func beanManager(_ beanManager: PTDBeanManager!, didConnect bean: PTDBean!, error: Error!)
     {
     bean.delegate = self
     }
     
     func bean(_ bean: PTDBean!, serialDataReceived data: Data!)
     {
     if(data != nil)
     {
     var receivedMessage = NSString(data:data, encoding: NSUTF8StringEncoding)
     print("From serial: (receivedMessage)")
     ledTextLabel.text = receivedMessage! as string
     }
     }*/
    
    func connectToBean(bean: PTDBean)
    {
        var error: NSError?
        print ("hi")
        beanManager!.connect(to: bean, withOptions:nil, error: &error)
        print("Bean connected")
        bean.delegate = self
        
        
    }
    
    
    func updateLedStatusText(lightState: Bool)
    {
        let onOffText = lightState ? "ON": "OFF"
        ledTextLabel.text = "Led is: \(onOffText)"
    }
    
    func sendSerialData(beanState: NSData)
    {
        print(myBean)
        print("bye")
        myBean?.sendSerialData(beanState as Data!)
    }
    
    func bean(_ bean: PTDBean!, serialDataReceived data: Data!)
    {
        //put this in a loop (while serialDataReceived < 1000 (so led has been turned on) or stop has been pressed)
        if(data != nil)
        {
            print(data)
            var receivedMessage = NSString(data:data, encoding: String.Encoding.utf8.rawValue)
            ledTextLabel.text = receivedMessage! as String
        }
    }
    
    @IBAction func pressButtonToChangeValue(_ sender: Any)
    {
        lightState = !lightState
        
        let data = NSData(bytes: &lightState, length: MemoryLayout<Bool>.size)
        sendSerialData(beanState: data)
        updateLedStatusText(lightState: lightState)
    }
    
    
}
