//
//  LocationManager.swift
//  LocationWrapper
//
//  Created by Chawatvish Worrapoj on 11/7/2561 BE.
//  Copyright © 2561 Chawatvish Worrapoj. All rights reserved.
//

import Foundation
import SwiftLocation
import CoreLocation

class LocationManager:NSObject {
    
    static let shared = LocationManager()
    
    override init() {
        super.init()
        setup()
    }
    
    private func setup() {
//        let _ = Locator.events.listen { newStatus in
//            switch newStatus {
//            case .authorizedAlways,.authorizedWhenInUse:
//                return true
//            case .denied,.notDetermined,.restricted:
//                return false
//            }
//        }
        
        
        
    }
    
    func requestAuthorization(vc:ViewController) {
        switch Locator.authorizationStatus {
        case .authorizedAlways,.authorizedWhenInUse:
            break
        case .notDetermined:
            Locator.requestAuthorizationIfNeeded()
            break
        case .denied,.restricted:
            let alertViewController = UIAlertController(title: "ท่านยังไม่ได้เปิดการใช้งานระบบระบุตำแหน่งที่ตั้ง", message: "การเปิดระบบระบุตำแหน่ง กดตั้งค่า -> ตำแหน่งที่ตั้ง -> ในขณะใช้แอพ", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ยกเลิก", style: .cancel, handler: nil)
            let settingAction = UIAlertAction(title: "ตั้งค่า", style: .default, handler: { (action) in
                UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
            })
            
            alertViewController.addAction(cancelAction)
            alertViewController.addAction(settingAction)
            
            DispatchQueue.main.async {
                vc.present(alertViewController, animated: true, completion: nil)
            }
            break
        }
    }
    
    func requestCurrentLocationOneShot(onSuccessCompltionHandler: @escaping ((CLLocation) -> (Void)),
                                       onFailureCompletionHandler: @escaping ((LocationError, CLLocation?) -> (Void))) {
        
        let onGetLocationWithGPSFail:(LocationError, Optional<CLLocation>) -> () = { _,_ in
            Locator.currentPosition(usingIP: .ipApi,
                                    onSuccess: onSuccessCompltionHandler,
                                    onFail: onFailureCompletionHandler)
        }
        
        Locator.currentPosition(accuracy: .room,
                                onSuccess: onSuccessCompltionHandler,
                                onFail: onGetLocationWithGPSFail)
    }
}
