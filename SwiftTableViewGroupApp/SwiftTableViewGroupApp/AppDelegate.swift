//
//  AppDelegate.swift
//  SwiftTableViewGroupApp
//
//  Created by 张行 on 2019/7/17.
//  Copyright © 2019 张行. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = UINavigationController(rootViewController: ViewController(nibName: nil, bundle: nil))
        self.window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func headerView<T:UIView>(view:T) -> UIView {
        return view
    }

    func makeView<T:UIView>(view:T) -> T {
        return view
    }
}


