//
//  HomeController.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/2/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
         setupViewControllers()
        
        
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let loginController = UINavigationController(rootViewController:LoginController())
                self.present(loginController, animated: true, completion: nil)
            }
            return
        }
  
    }

   
 
    
    
     func setupViewControllers() {

        
        //Home Feed
        let layout = UICollectionViewFlowLayout()
        let homeController = HomeFeedController(collectionViewLayout: layout)
        let homeNavController = UINavigationController(rootViewController: homeController)
        homeNavController.navigationBar.backgroundColor = UIColor.black
        homeNavController.tabBarItem.image = #imageLiteral(resourceName: "feed-tabIcon")
      
        
        //Group Chat
        let layout1 = UICollectionViewFlowLayout()
        let groupController = GroupChatController(collectionViewLayout: layout1)
        let groupNavController = UINavigationController(rootViewController: groupController)
        
        groupNavController.tabBarItem.image = #imageLiteral(resourceName: "groups-tabIcon")
        
        
        //User Profile
        
        let layout2 = UICollectionViewFlowLayout()
        let profileController = UserProfileController(collectionViewLayout: layout2)
        let profileNavController = UINavigationController(rootViewController: profileController)
       
       profileNavController.tabBarItem.image = #imageLiteral(resourceName: "me-tabIcon")
        
        UITabBar.appearance().barTintColor =  UIColor.darkGray
        tabBar.tintColor = UIColor.green
        
        viewControllers = [homeNavController,groupNavController,profileNavController]
       
    }


}

