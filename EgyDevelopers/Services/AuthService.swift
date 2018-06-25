//
//  AuthService.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/3/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    
   static let instance = AuthService()
   
    func registerUser(email : String , password : String , userCreationComplete : @escaping (_ status : Bool ,_ error : Error?) -> () )
    {
        
        Auth.auth().createUser(withEmail: email, password: password) { (returnUser, error) in
            
            if error != nil {
                userCreationComplete(false,error)
                return
            }
            guard let returnUser = returnUser else { return }
            let _userData = ["email" : email , "provider" : returnUser.user.providerID]
            DataService.instance.createDBUser(uid: returnUser.user.uid, userData: _userData)
           
            userCreationComplete(true,nil)
        }
        
    }
    
    
    func loginUser(email : String , password : String , loginComplete : @escaping (_ status : Bool ,_ error : Error?) -> () ){
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                loginComplete(false,error)
                return
            }
            
            loginComplete(true,nil)
        })
    }
    
}

