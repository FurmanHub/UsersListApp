//
//  AppDelegate.swift
//  UsersListApp
//
//  Created by Fedya on 1/15/19.
//  Copyright © 2019 Fedya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabbarController = UITabBarController()
        let usersListNavController = UINavigationController(rootViewController: UsersListViewController())
        let savedUsersListNavController = UINavigationController(rootViewController: UIViewController())
        tabbarController.setViewControllers([usersListNavController, savedUsersListNavController], animated: false)
        tabbarController.tabBar.barStyle = .default
        window!.rootViewController = tabbarController
        window!.makeKeyAndVisible()
        return true
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

