//
//  AppDelegate.swift
//  engage-timer-updated
//
//  Created by Adam Reed on 2/6/20.
//  Copyright © 2020 rdConcepts. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    var firstTimeUser = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Setup google admob instance
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        // Capture app information for Firebase
        FirebaseApp.configure()
        
        // Change options for audio session to keep users background music playing.
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        
        // If user is using the app, stop the idle timer from closing the app
        UIApplication.shared.isIdleTimerDisabled = true
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

