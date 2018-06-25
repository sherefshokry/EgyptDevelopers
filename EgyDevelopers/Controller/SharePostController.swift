//
//  SharePostController.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/3/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit
import Firebase
class SharePostController: UIViewController , UITextViewDelegate{

    
    
    let closeButton : UIButton = {
       let button  = UIButton()
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    
    let navTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "_newpost"
        label.textColor = UIColor.green
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    
    let userProfileImageView : UIImageView = {
       let view = UIImageView()
        view.image = #imageLiteral(resourceName: "defaultProfileImage")
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
         return view
        
    }()
    
    
    
    let userEmail : UILabel = {
      let label = UILabel()
        label.text = "sheref_shokry@yahoo.com"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    let postTextView : UITextView = {
       let view = UITextView()
       view.text = "Say Something Here ..... !"
       view.textColor = UIColor.white
        view.font = UIFont.boldSystemFont(ofSize: 14)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var containerView : UIView = {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        button.setTitle(" SEND", for: .normal)
        button.backgroundColor = UIColor.black
        button.setTitleColor(UIColor.green, for: .normal)
        button.addTarget(self, action: #selector(handelSendPost), for: .touchUpInside)
        view.addSubview(button)
        
        button.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leadingAnchor, right: view.trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        
        return view
    }()
    
    
    @objc func handelSendPost() {
       
      guard let uid =  Auth.auth().currentUser?.uid else { return }
      print("send post .... ")
        DataService.instance.uploadPost(withMessage: postTextView.text!, forUID: uid, withGroupKey: nil) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print("Error")
            }
        }
    
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.rgb(red: 65, green: 69, blue: 80)
         postTextView.delegate = self
        
        let navigationBar = UIView()
        navigationBar.backgroundColor = UIColor.rgb(red: 41, green: 43, blue: 52)
        
        view.addSubview(navigationBar)
        
        navigationBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.safeAreaLayoutGuide.leadingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 50)
        
       navigationBar.addSubview(closeButton)
        
        closeButton.anchor(top: navigationBar.topAnchor, bottom: navigationBar.bottomAnchor, left: navigationBar.leadingAnchor, right: nil, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 0, width: 50, height: 0)
        
        navigationBar.addSubview(navTitleLabel)
        
        navTitleLabel.anchor(top: navigationBar.topAnchor, bottom: navigationBar.bottomAnchor, left: closeButton.trailingAnchor, right: navigationBar.trailingAnchor, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 55, width: 0, height: 0)
        
        
   //     setupNavigationItems()
         setupNewPostLayout()
       
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
     userEmail.text = Auth.auth().currentUser?.email
    }
  
   

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        postTextView.text = ""
    }
    
    
    
    
    
   /* func setupNavigationItems() {
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.green]
        self.navigationItem.title = "_postsomething"
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.green
        
    }*/

    func  setupNewPostLayout() {
        view.addSubview(userProfileImageView)
        
        userProfileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.safeAreaLayoutGuide.leadingAnchor, right: nil, topPadding: 70, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 60, height: 60)
        
        view.addSubview(userEmail)
        
        userEmail.anchor(top: nil, bottom: nil, left: userProfileImageView.trailingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 0, height: 60)
        userEmail.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor).isActive = true
        
        view.addSubview(postTextView)
        
        postTextView.anchor(top: userProfileImageView.bottomAnchor, bottom: nil, left: view.safeAreaLayoutGuide.leadingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 0)
        
        postTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        
        
    }
    
  
    override var inputAccessoryView: UIView? {
        get{
            return containerView
        }
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    
    
}
