//
//  AppDelegate.swift
//  Wunderfleet
//
//  Created by Ruben Blanco on 11/7/21.
//

import UIKit

import PKHUD

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        self.setupApp()
        // Start app Coordinator and Mock Services
        let apiService = API()
        //let apiService = MockAPI()
        self.appCoordinator = AppCoordinator(window: window, apiService: apiService)
        self.appCoordinator.start()
        
        return true
    }
    
}

// MARK: Global Customization

extension AppDelegate {
    
    private func setupApp() {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
    }
    
}
