//
//  AppDelegate.swift
//  MyLocations
//
//  Created by Paul Tiriteu on 14/02/2020.
//  Copyright © 2020 Paul Tiriteu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let router = MainRouter()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = router.getLocationsViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

