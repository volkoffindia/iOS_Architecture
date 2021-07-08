//
//  AppDelegate.swift
//  Sample
//
//  Created by Volkoff India on 15/06/21.
//

import UIKit

let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: application Lifecycle
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let viewController = HomeVC.loadFromNib()
        let navC = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = navC
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        return true
    }
}
