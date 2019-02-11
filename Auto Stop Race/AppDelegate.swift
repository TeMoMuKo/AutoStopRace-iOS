//
//  AppDelegate.swift
//  Auto Stop Race
//
//  Created by Robert Ignasiak on 16.02.2017.
//  Copyright © 2017 Torianin. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var appCoordinator: AppCoordinator!
    public var window: UIWindow?

    static var shared: AppDelegate { return UIApplication.shared.delegate as! AppDelegate }

    var applicationStateString: String {
        if UIApplication.shared.applicationState == .active {
            return "active"
        } else if UIApplication.shared.applicationState == .background {
            return "background"
        } else {
            return "inactive"
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        setupFirebase()

        application.registerForRemoteNotifications()
        requestNotificationAuthorization(application: application)

        if let userInfo = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] {
            NSLog("[RemoteNotification] applicationState: \(applicationStateString) didFinishLaunchingWithOptions for iOS9: \(userInfo)")
            //TODO: Handle background notification
        }

        let appWindow = UIWindow(frame: UIScreen.main.bounds)
        appWindow.backgroundColor = UIColor.white

        let applicationController = UIViewController()
        appWindow.rootViewController = applicationController
        self.window = appWindow

        appCoordinator = AppCoordinator(applicationController: applicationController)
        appCoordinator?.start()

        appWindow.makeKeyAndVisible()

        setupView(application)
        return true
    }

    private func setupView(_ application: UIApplication) {
        setUpNavigationBar()
        application.statusBarStyle = .lightContent
    }
    
    private func setUpNavigationBar() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = Theme.Color.blueMenu
        UINavigationBar.appearance().tintColor = UIColor.white
    }

    private func setupFirebase() {
        FirebaseApp.configure()
    }

    func requestNotificationAuthorization(application: UIApplication) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
    }
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    // iOS10+, called when presenting notification in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        NSLog("[UserNotificationCenter] applicationState: \(applicationStateString) willPresentNotification: \(userInfo)")
        //TODO: Handle foreground notification
        completionHandler([.alert])
    }

    // iOS10+, called when received response (default open, dismiss or custom action) for a notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        NSLog("[UserNotificationCenter] applicationState: \(applicationStateString) didReceiveResponse: \(userInfo)")
        //TODO: Handle background notification
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        NSLog("[RemoteNotification] didRefreshRegistrationToken: \(fcmToken)")
    }

    // iOS9, called when presenting notification in foreground
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        NSLog("[RemoteNotification] applicationState: \(applicationStateString) didReceiveRemoteNotification for iOS9: \(userInfo)")
        if UIApplication.shared.applicationState == .active {
            //TODO: Handle foreground notification
        } else {
            //TODO: Handle background notification
        }
    }
}
