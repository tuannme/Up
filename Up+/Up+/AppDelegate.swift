//
//  AppDelegate.swift
//  Up+
//
//  Created by Dreamup on 2/7/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import SendBirdSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        DispatchQueue.main.async {
          FIRApp.configure()
          GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        }
        SBDMain.initWithApplicationId(SENDBIRD_ID)

        return true
    }
    
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    
}

