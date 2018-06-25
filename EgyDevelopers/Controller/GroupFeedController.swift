//
//  GroupFeedController.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/6/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit
import Firebase


class GroupFeedController: UIViewController ,  UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UITextFieldDelegate {

    let cellId = "cellId"
    var messages = [Message]()
    var group : Group? {
        didSet{
            guard let group = group else { return }
            navTitleLabel.text = group.groupTitle
            
            DataService.instance.getEmails(withGroup: group) { (emailsArray) in
            self.groupMembersLabel.text = emailsArray.joined(separator: ", ")
            }
           
        }
    }
    
    let closeButton : UIButton = {
        let button  = UIButton()
        button.setImage(#imageLiteral(resourceName: "backIcon"), for: .normal)
        button.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        return button
    }()
    
    @objc func handleCloseButton() {
        dismissDetail()
    }

    
    var navTitleLabel : UILabel = {
        let label = UILabel()
        label.text = "_grouptitle"
        label.textColor = UIColor.green
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    let groupMembersLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.green
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var  collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.rgb(red: 65, green: 69, blue: 80)
        collectionView.delegate = self
        collectionView.dataSource  = self
        collectionView.register(GroupFeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        return collectionView
    }()
    
    lazy var textField : UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.placeholder = " send a message..."
        tf.delegate = self
        return tf
    }()

    
    lazy var containerView : UIView = {
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        view.backgroundColor = UIColor.rgb(red: 65, green: 69, blue: 80)
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.addTarget(self, action: #selector(handelSendPost), for: .touchUpInside)
        view.addSubview(button)
        
        button.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: nil, right: view.trailingAnchor, topPadding: 10, bottomPadding: 10, leftPadding: 5, rightPadding: 10, width: 50, height: 0)
        
        
        view.addSubview(textField)
        textField.anchor(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leadingAnchor, right: button.leadingAnchor, topPadding: 10, bottomPadding: 10, leftPadding: 10, rightPadding: 0, width: 0, height: 0)
        
        return view
    }()
    
    
    @objc func handelSendPost() {
        
        guard let uid =  Auth.auth().currentUser?.uid else { return }
        DataService.instance.uploadPost(withMessage: textField.text!, forUID: uid, withGroupKey: group?.groupKey) { (success) in
            if success {
                self.textField.text = ""
            }
            else {
                print("error")
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.rgb(red: 65, green: 69, blue: 80)
        
        let navigationBar = UIView()
        navigationBar.backgroundColor = UIColor.rgb(red: 41, green: 43, blue: 52)
        
        view.addSubview(navigationBar)
        
        navigationBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.safeAreaLayoutGuide.leadingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 50)
        
        navigationBar.addSubview(closeButton)

        closeButton.anchor(top: navigationBar.topAnchor, bottom: navigationBar.bottomAnchor, left: navigationBar.leadingAnchor, right: nil, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 0, width: 50, height: 0)
        
        navigationBar.addSubview(navTitleLabel)
        
        navTitleLabel.anchor(top: navigationBar.topAnchor, bottom: navigationBar.bottomAnchor, left: closeButton.trailingAnchor, right: navigationBar.trailingAnchor, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 55, width: 0, height: 0)
        
        
        let membersBar = UIView()
         membersBar.backgroundColor = UIColor.rgb(red: 41, green: 43, blue: 52)
        
        view.addSubview(membersBar)
        membersBar.anchor(top: navigationBar.bottomAnchor, bottom: nil, left: view.safeAreaLayoutGuide.leadingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 30)
        
        
        membersBar.addSubview(groupMembersLabel)
        groupMembersLabel.anchor(top: membersBar.topAnchor, bottom: membersBar.bottomAnchor, left: membersBar.leadingAnchor, right: membersBar.trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        
        
        view.addSubview(collectionView)
        
        collectionView.anchor(top: membersBar.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.safeAreaLayoutGuide.leadingAnchor, right: view.safeAreaLayoutGuide.trailingAnchor, topPadding: 0, bottomPadding: 50, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
    
    
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(" View will Appear ")
        DataService.instance.getAllMessages(forGroup: self.group!) { (returnedMessages) in
            self.messages = returnedMessages
            self.collectionView.reloadData()
        
            if self.messages.count > 0 {
                
                self.collectionView.scrollToItem(at: IndexPath(item: self.messages.count - 1 , section: 0), at: .top , animated: true)
                
            }
        }
        
    }
    
  
    
    //This is for the keyboard to GO AWAYY !! when user clicks "Return" key  on the keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override var inputAccessoryView: UIView? {
        get{
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GroupFeedCell
        cell.message = messages[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let dummyCell = GroupFeedCell(frame: frame)
        
        dummyCell.message = messages[indexPath.item]
        dummyCell.layoutIfNeeded()
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize =  dummyCell.systemLayoutSizeFitting(targetSize)
        
        let height = max(55, estimatedSize.height)
        print("height : " , estimatedSize.height)
        return CGSize(width: collectionView.frame.size.width, height: height)
    
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
  
    
    
    
    
    
    
}
