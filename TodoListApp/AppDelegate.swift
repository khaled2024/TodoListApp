//
//  AppDelegate.swift
//  TodoListApp
//
//  Created by KhaleD HuSsien on 07/12/2021.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
        do{
             _ = try Realm()
        }catch{
            print("Error of creating new Realm \(error)")
        }
        return true
    }
}

