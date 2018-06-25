//
//  LogoutHandlers.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/3/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit
import Firebase

extension UserProfileController {
    
    
    @objc func handleLogOut() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do{
                try Auth.auth().signOut()
                
                let loginController = UINavigationController(rootViewController:LoginController())
                self.present(loginController, animated: true, completion: nil)
            }
            catch let error {
                // create the alert
                print(error.localizedDescription)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel" , style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
}
