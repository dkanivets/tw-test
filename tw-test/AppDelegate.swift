//
//  AppDelegate.swift
//  tw-test
//
//  Created by Dmitry Kanivets on 06.04.18.
//  Copyright © 2018 Dmitry Kanivets. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController(rootViewController: ProjectsViewController())
        navController.navigationBar.isTranslucent = false

        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
}

