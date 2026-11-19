//
//  AppDelegate.swift
//  Leaktronics
//
//  Created by Abhishek Mullick on 06/04/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import Firebase
import CoreData
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var nav : UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Delay 1 second
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 2.0))
        
        //FirebaseApp SetUp
        FirebaseApp.configure()
        
        UIApplication.shared.delegate = self
        IQKeyboardManager.shared.enable = true
        UserDefaults.standard.removeObject(forKey: "PoolDetectionUserName")
        UserDefaults.standard.removeObject(forKey: "returnKeyForPoolDetect")
        UserDefaults.standard.removeObject(forKey: "PlumberLeakUserName")
        UserDefaults.standard.removeObject(forKey: "returnKeyForPlumberLeak")
        UserDefaults.standard.removeObject(forKey: "InspectionUserName")
        UserDefaults.standard.removeObject(forKey: "returnKeyForInspection")
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        //return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        
        let config = UISceneConfiguration(name: "Default Configuration", sessionRole: .windowApplication)
        config.sceneClass = UIWindowScene.self
        config.delegateClass = SceneDelegate.self
        if UIDevice.current.userInterfaceIdiom == .phone {
            config.storyboard = UIStoryboard(name: "Main_iPhone", bundle: nil)
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            config.storyboard = UIStoryboard(name: "Main_iPad", bundle: nil)
        }
        
        return config
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Leaktronics")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

