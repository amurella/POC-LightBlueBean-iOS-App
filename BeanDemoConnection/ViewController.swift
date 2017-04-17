//
//  ViewController.swift
//  BeanDemoConnection
//
//  Created by Akhila Murella on 4/15/17.
//  Copyright © 2017 Akhila Murella. All rights reserved.
//

import UIKit
import Bean_iOS_OSX_SDK
import CoreBluetooth

class ViewController: UIViewController, PTDBeanManagerDelegate, PTDBeanDelegate {

    @IBOutlet weak var valueFromBean: UILabel!
    @IBOutlet weak var ledTextLabel: UILabel!
    var beanManager: PTDBeanManager!
    var myBean: PTDBean!
    var lightState: Bool = false
    var startReading: Bool = false
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beanManager = PTDBeanManager()
        beanManager!.delegate = self
    }
    
    
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

    
    func beanManager(_ beanManager: PTDBeanManager!, didDiscover bean: PTDBean!, error: Error!) {
        if myBean == nil {
            if bean.state == .discovered {
                print("bean discovered")
                //       beanDiscovered = true
                viewDidAppear(true)
                myBean = bean
                beanManager!.connect(to: bean, withOptions:nil, error: nil)
                bean.delegate = self
            }
        }
        
        #if DEBUG
            print("DISCOVERED BEAN \nName: \(bean.name), UUID: \(bean.identifier) RSSI: \(bean.rssi)")
        #endif
    }
    
 
    
    
   
     
    /* func bean(_ bean: PTDBean!, serialDataReceived data: Data!)
     {
     if(data != nil)
     {
     var receivedMessage = NSString(data:data, encoding: String.Encoding.utf8.rawValue)
     print("From serial: (receivedMessage)")
     ledTextLabel.text = receivedMessage! as string
     }
     }*/
    
   /* func connectToBean(bean: PTDBean)
    {
        var error: NSError?
        print ("hi")
        beanManager!.connect(to: bean, withOptions:nil, error: &error)
        print("Bean connected")
        bean.delegate = self
        
        
    }*/
    
    
    @IBAction func pressValueToStartReading(_ sender: Any)
    {
        startReading = true
        let data = NSData(bytes: &lightState, length: MemoryLayout<Bool>.size)
        sendSerialData(beanState: data)
        print ("HI")
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
        print("sent over serial data")
    }
    

    func bean(_ bean: PTDBean!, serialDataReceived data: Data!)
    {
        if(data != nil)
        {
            print ("Received Data")
        }
        
        var stringData : String = NSString(data: data, encoding : String.Encoding.ascii.rawValue) as! String
        valueFromBean.text? += stringData
        //var fullString : String = valueFromBean.text!
        
       // valueFromBean.scrollRangeToVisible(NSMakeRange(count(valueFromBean.string!),0))
        //put this in a loop (while serialDataReceived < 1000 (so led has been turned on) or stop has been pressed)
       /* if(data != nil)
        {
            var stringReceived: String = ""
            
            let nLength: Int = data.count / MemoryLayout<UInt8>.size
            var arrData: [UInt8] = [UInt8](repeating: 0, count: nLength)
            data.copyBytes(to: &arrData, count: nLength)
            
            var n: Int = 0
            while(n < nLength)
            {
                let str = String(UnicodeScalar(arrData[n]))
                stringReceived += str
                n += 1
            }
            print(stringReceived)
         //   var receivedMessage = NSString(data:data, encoding: String.Encoding.utf8.rawValue)
            valueFromBean.text = stringReceived as String
        }*/
    
        //    NSString *uuidSubstring = [bean.identifier.UUIDString substringFromIndex:bean.identifier.UUIDString.length-4];
        //    serialOutput = [NSString stringWithFormat:@"%@-%@:%@", bean.name, uuidSubstring, serialOutput];
        
       /* if(serialOutput)
        {
            serialOutput = [self.consoleOutputTextView.string stringByAppendingString:serialOutput];
            self.consoleOutputTextView.string = serialOutput;
        }
        
        [self.consoleOutputTextView scrollRangeToVisible: NSMakeRange(self.consoleOutputTextView.string.length, 0)];*/
    }
    
    @IBAction func pressButtonToChangeValue(_ sender: Any)
    {
        lightState = !lightState
        
        let data = NSData(bytes: &lightState, length: MemoryLayout<Bool>.size)
        sendSerialData(beanState: data)
        updateLedStatusText(lightState: lightState)
    }
    
    
}
