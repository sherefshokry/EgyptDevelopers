//
//  Handlers.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/3/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

extension LoginController {
    
    @objc func  handleCustomFaceBookLogin() {
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email"], from: self) { (result, err) in
            if err != nil {
                print("Custom FB Login failed:",String(describing : err?.localizedDescription))
                return
            }
            
            self.showEmailAddress()
        }
        
    }
    
    
    func showEmailAddress() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        Auth.auth().signInAndRetrieveData(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user: ", error ?? "")
                return
            }
            self.dismiss(animated: true, completion: nil)
            guard let email = user?.user.email else { return }
            guard let providerID = user?.user.providerID else { return }
            guard let uid = user?.user.uid else { return }
            let _userData = ["email" : email , "provider" : providerID]
            
            DataService.instance.createDBUser(uid: uid, userData: _userData)
            
            print("Successfully logged in with our user: ", user ?? "")
        })
    }
    
    
   
    @objc func handleCustomGoogleSign() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    
 
    @objc func handleEmailLogin() {
        
        self.navigationController?.navigationBar.isHidden = false
        let emailLoginController =  EmailLoginController()
        self.navigationController?.pushViewController(emailLoginController, animated: true)
        
        
    }
    
}

extension EmailLoginController {
    

    @objc func  handleSignIn(){
        
        AuthService.instance.loginUser(email: emailTextField.text!, password: passwordTextField.text!) { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                return
            }
            else {
                
                  print(String(describing: error?.localizedDescription))
            }
        AuthService.instance.registerUser(email: self.emailTextField.text!, password: self.passwordTextField.text!) { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print(String(describing: error?.localizedDescription))
            }
            
        }
        }
    }
    
  
    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.count ?? 0 > 0  && passwordTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            logInButton.isEnabled = true
            logInButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        }
        else {
            logInButton.isEnabled = false
        }
        
        
        
    }
    
    
}





