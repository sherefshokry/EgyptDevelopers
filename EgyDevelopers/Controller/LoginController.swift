//
//  LoginController.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/2/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class LoginController: UIViewController , GIDSignInUIDelegate , GoogleLoginDelegate , FBSDKLoginButtonDelegate {
  
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
       // showEmailAddress()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
 
    
    
    
    
    let backImageView : UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFill
       imageView.image = #imageLiteral(resourceName: "loginBGImage")
        
        return imageView
        
    }()
    
    let loginLabel : UILabel = {
       let label = UILabel()
        label.text = "Login"
        label.textColor = UIColor.rgb(red: 4, green: 171, blue: 197)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
        
    }()
    
    lazy var facebookLoginButton : UIButton = {

        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
        
       let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 67, green: 91, blue: 145)
        button.setTitle("LOGIN WITH FB", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleCustomFaceBookLogin), for: .touchUpInside)
        
        loginButton.addSubview(button)
        button.anchor(top: loginButton.topAnchor, bottom: loginButton.bottomAnchor, left: loginButton.leadingAnchor, right: loginButton.trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        return button
    }()
    
 
    lazy var googleLoginButton : UIButton = {
        let button = GIDSignInButton()
        
        let customButton = UIButton(type: .system)
        customButton.backgroundColor = UIColor.rgb(red: 206, green: 84, blue: 61)
         customButton.setTitle("LOGIN WITH GOOGLE", for: .normal)
         customButton.setTitleColor(UIColor.white, for: .normal)
         customButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
         customButton.addTarget(self, action: #selector(handleCustomGoogleSign), for: .touchUpInside)
        
        button.addSubview(customButton)
        customButton.anchor(top: button.topAnchor, bottom: button.bottomAnchor, left: button.leadingAnchor, right: button.trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        
        
        return customButton
    }()
   
    func didGoogleLogin() {
        self.dismiss(animated: true, completion: nil)
    }
    
    let orLabel : UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.textColor = UIColor.rgb(red: 4, green: 171, blue: 197)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
     }()
    
    
    let emailLoginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "emailIcon") , for: .normal)
        button.setTitle(" by email", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleEmailLogin), for: .touchUpInside)
        return button
    }()
    
 
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()


      GIDSignIn.sharedInstance().uiDelegate = self
      appDelegate.delegate = self
     view.backgroundColor = UIColor.rgb(red: 41, green: 43, blue: 52)
    
        
        
        setupBackImageView()
        setupLoginContainerLayout()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    self.navigationController?.navigationBar.isHidden = true
        
    }
    
    
    fileprivate func setupBackImageView(){
        
        view.addSubview(backImageView)
        
        backImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.safeAreaLayoutGuide.leadingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        backImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
    }
    
    fileprivate func setupLoginContainerLayout()
    {
     let containerView = UIView()
       containerView.backgroundColor = UIColor.rgb(red: 65, green: 69, blue: 80)
        containerView.layer.shadowOpacity = 0.75
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowColor  = UIColor.black.cgColor
      view.addSubview(containerView)
      
        containerView.anchor(top: nil, bottom: nil, left: view.safeAreaLayoutGuide.leadingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 15, rightPadding: 15, width: 0, height: 0)
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
     
     
        
        
        
        
      let stackView = UIStackView(arrangedSubviews: [loginLabel,facebookLoginButton,googleLoginButton,orLabel])
       stackView.axis = .vertical
       stackView.distribution = .fillEqually
       stackView.spacing = 12
        
       containerView.addSubview(stackView)
      
       stackView.anchor(top: containerView.topAnchor, bottom: nil, left: containerView.leadingAnchor, right: containerView.trailingAnchor, topPadding: 8, bottomPadding: 0, leftPadding: 15, rightPadding: 15, width: 0, height: 0)
        
       stackView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.70).isActive = true
        
        
        containerView.addSubview(emailLoginButton)
        
        emailLoginButton.anchor(top: nil, bottom: containerView.bottomAnchor, left: containerView.leadingAnchor, right: containerView.trailingAnchor, topPadding: 0, bottomPadding: 15, leftPadding: 15, rightPadding: 15, width: 0, height: 0)
        emailLoginButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.10).isActive = true
        
    }
    
  
}
