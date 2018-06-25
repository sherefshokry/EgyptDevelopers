//
//  EmailLoginController.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/2/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit
import Firebase

class EmailLoginController: UIViewController {


    let loginLabel : UILabel = {
        let label = UILabel()
        label.text = "email sign in"
        label.textColor = UIColor.rgb(red: 4, green: 171, blue: 197)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
        
    }()
    
    let emailTextField : UITextField = {
        let txt = UITextField()
        txt.attributedPlaceholder = NSAttributedString(string: "Email",attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        txt.textColor = UIColor.white
        txt.font = UIFont.systemFont(ofSize: 20)
        txt.backgroundColor = UIColor.darkGray
        txt.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        txt.borderStyle = .roundedRect
        return txt
    }()
    
    let passwordTextField : UITextField = {
        let txt = UITextField()
         txt.attributedPlaceholder = NSAttributedString(string: "Password",attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        txt.textColor = UIColor.white
        txt.isSecureTextEntry = true
        txt.font = UIFont.systemFont(ofSize: 20)
        txt.backgroundColor = UIColor.darkGray
        txt.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        txt.borderStyle = .roundedRect
        return txt
    }()
    
    lazy var logInButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN IN", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        view.backgroundColor = UIColor.rgb(red: 65, green: 69, blue: 80)
        
       setupNavigationItems()
      setupLoginItemsLayout()
        
    }
    
    
    func setupNavigationItems() {
    self.navigationController?.navigationBar.barTintColor = .black
     self.navigationItem.leftBarButtonItem?.tintColor = UIColor.green
}
    
    fileprivate func setupLoginItemsLayout() {
        
        let stackView = UIStackView(arrangedSubviews: [loginLabel,emailTextField,passwordTextField])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        
        view.addSubview(stackView)
        
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.safeAreaLayoutGuide.leadingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, topPadding: 30, bottomPadding: 0, leftPadding: 20, rightPadding: 20, width: 0, height: 0)
        
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        
        view.addSubview(logInButton)
        
        logInButton.anchor(top: stackView.bottomAnchor, bottom: nil, left: stackView.leadingAnchor, right: stackView.trailingAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 50)
        
    }
    

 
}
