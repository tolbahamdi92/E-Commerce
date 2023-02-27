//
//  AppDelegate.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/23/23.
//

import UIKit
import FirebaseCore
import IQKeyboardManagerSwift
import GoogleSignIn
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
         let clientID = FirebaseApp.app()?.options.clientID

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID!)
        GIDSignIn.sharedInstance.configuration = config
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(app, open: url, options: options)
        return GIDSignIn.sharedInstance.handle(url)
    }
}

