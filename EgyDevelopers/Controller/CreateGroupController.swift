//
//  CreateGroupController.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/5/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit
import Firebase
class CreateGroupController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UITextFieldDelegate , UserCellDelegate {
   
    

    
     let cellId = "cellId"

    var emailsArray = [String]()
    var chosenUserArray = [String]()
    
    let closeButton : UIButton = {
        let button  = UIButton()
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    let doneButton : UIButton = {
        let button  = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.addTarget(self, action: #selector(handleDoneButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDoneButton()
    {

        if titleLabel.text != "" && descriptionLabel.text != "" {
            
            DataService.instance.getIds(forUserEmails: chosenUserArray) { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                
                DataService.instance.createGroup(withTitle: self.titleTextField.text!, andDescription: self.descriptionTextField.text!, forUserIds: userIds, completion: { (groupCreated) in
                    if groupCreated {
                        self.dismiss(animated: true, completion: nil)
                    }
                    else {
                        print("group not created ,please try again")
                    }
                
                })
                
            }
            
        }
    
    }
    
    
    let navTitleLabel : UILabel = {
       let label = UILabel()
        label.text = "_newgroup"
        label.textColor = UIColor.green
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    lazy var  collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.rgb(red: 41, green: 43, blue: 52)
        collectionView.delegate = self
        collectionView.dataSource  = self
        collectionView.register(UserEmailCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "title"
        label.textColor = UIColor.green
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    let titleTextField : UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "give your group a title",attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        textField.layer.borderWidth = 0.5
        textField.textColor = UIColor.white
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    }()
    
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "description"
        label.textColor = UIColor.green
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    let descriptionTextField : UITextField = {
        let textField = UITextField()
         textField.layer.borderWidth = 0.5
        textField.attributedPlaceholder = NSAttributedString(string: "give your group a description",attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        textField.textColor = UIColor.white
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    }()
    
    
    
    let addPeopleLabel : UILabel = {
        let label = UILabel()
        label.text = "add people to your group"
        label.textColor = UIColor.green
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var addPeopleTextField : UITextField = {
        let textField = UITextField()
          textField.attributedPlaceholder = NSAttributedString(string: "enter an email...",attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
       
        textField.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
       textField.layer.borderWidth = 0.5
        textField.textColor = UIColor.white
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        return textField
    }()
    
    @objc func handleTextChange(){
       
        if self.addPeopleTextField.text == "" {
            self.emailsArray = []
            self.collectionView.reloadData()
        }
        else {
            
            DataService.instance.getEmail(forSearchQuery: addPeopleTextField.text!) { (emails) in
               
                self.emailsArray = emails
                self.collectionView.reloadData()
                
            }
           
        }
      
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = UIColor.rgb(red: 65, green: 69, blue: 80)
        
       addPeopleTextField.delegate = self
       titleTextField.delegate = self
       descriptionTextField.delegate = self
        let navigationBar = UIView()
        navigationBar.backgroundColor = UIColor.rgb(red: 41, green: 43, blue: 52)
        
        view.addSubview(navigationBar)
        
        navigationBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.safeAreaLayoutGuide.leadingAnchor, right:
            view.safeAreaLayoutGuide.trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 50)
        
        navigationBar.addSubview(closeButton)
        
        closeButton.anchor(top: navigationBar.topAnchor, bottom: navigationBar.bottomAnchor, left: navigationBar.leadingAnchor, right: nil, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 0, width: 50, height: 0)
        
        navigationBar.addSubview(doneButton)
        
        doneButton.anchor(top: navigationBar.topAnchor, bottom: navigationBar.bottomAnchor, left: nil, right: navigationBar.trailingAnchor, topPadding: 5, bottomPadding: 5, leftPadding: 0, rightPadding: 5, width: 50, height: 0)
        
        navigationBar.addSubview(navTitleLabel)
        
        navTitleLabel.anchor(top: navigationBar.topAnchor, bottom: navigationBar.bottomAnchor, left: closeButton.trailingAnchor, right: doneButton.leadingAnchor, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 5, width: 0, height: 0)
        
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel,titleTextField,descriptionLabel,descriptionTextField,addPeopleLabel,addPeopleTextField])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
    
        
        
        view.addSubview(stackView)
        
        stackView.anchor(top: navigationBar.bottomAnchor, bottom: nil, left: view.safeAreaLayoutGuide.leadingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 5, width: 0, height: 0)
        stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
      
       
     
       
        view.addSubview(collectionView)
     
        collectionView.anchor(top: stackView.bottomAnchor, bottom: view.bottomAnchor, left: view.safeAreaLayoutGuide.leadingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 5, width: 0, height: 0)
      
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneButton.isHidden = true
            }
    
    
    func didSelectUser(email: String) {
        chosenUserArray.append(email)
        addPeopleLabel.text = chosenUserArray.joined(separator: ", ")
        doneButton.isHidden = false
    }
    
    func didUnSelectUser(email: String) {
        chosenUserArray = chosenUserArray.filter({ $0 != email })
        if chosenUserArray.count >= 1 {
            addPeopleLabel.text = chosenUserArray.joined(separator: ", ")
        doneButton.isHidden = false
        }
        else {
            addPeopleLabel.text = "add people to your group"
            doneButton.isHidden = true
        }
        
    }
    
    
    //This is for the keyboard to GO AWAYY !! when user clicks "Return" key  on the keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return emailsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserEmailCell
        cell.delegate = self
        cell.email = emailsArray[indexPath.item]
      
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
