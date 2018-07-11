//
//  ViewController.swift
//  LocationWrapper
//
//  Created by Chawatvish Worrapoj on 10/7/2561 BE.
//  Copyright © 2561 Chawatvish Worrapoj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func requestAuthroize() {
        LocationManager.shared.requestAuthorization(vc: self)
    }
    
    @IBAction func requestCurrentLocationOneShot() {
        LocationManager
            .shared
            .requestCurrentLocationOneShot(
                onSuccessCompltionHandler: { (location) -> (Void) in
                    print("current location : (\(location.coordinate.latitude),\(location.coordinate.longitude))")
            }) { (error, locaiton) -> (Void) in
                print("error")
        }
    }
    
    @IBAction func requestCurrentLocation() {
        
    }
    
}
