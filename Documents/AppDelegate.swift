//
//  AppDelegate.swift
//  Documents
//
//  Created by Андрей Васильев on 20.12.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MainTabBarController()
        self.window?.makeKeyAndVisible()
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        return true

    }

}

