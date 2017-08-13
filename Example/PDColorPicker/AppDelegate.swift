//
//  AppDelegate.swift
//  PDColorPicker
//
//  Created by dilorenzopl@gmail.com on 08/08/2017.
//  Copyright (c) 2017 dilorenzopl@gmail.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()

    return true
  }

}

