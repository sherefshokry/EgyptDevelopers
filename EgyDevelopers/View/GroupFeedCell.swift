//
//  GroupFeedCell.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/6/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit

class GroupFeedCell: UICollectionViewCell {
 
    var message : Message? {
        didSet{
            guard let message = message else { return }
            
        messageContent.text =  message.content
          userEmail.text = message.senderEmail
        }
    }
    
    
    let userProfileImageView : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "defaultProfileImage")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let userEmail : UILabel = {
        let label = UILabel()
        label.text = "Shokry@yahoo.com"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    var messageContent : UITextView = {
        let tv = UITextView()
         tv.backgroundColor = UIColor.rgb(red: 41, green: 43, blue: 52)
         tv.textColor = UIColor.white
         tv.isScrollEnabled = false
         tv.font = UIFont.boldSystemFont(ofSize: 16)
        return tv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.rgb(red: 41, green: 43, blue: 52)
        
        addSubview(userProfileImageView)
        
        userProfileImageView.anchor(top: topAnchor, bottom: nil, left: leadingAnchor, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 50, height: 50)
        userProfileImageView.layer.cornerRadius = 50/2
        
        addSubview(userEmail)
        userEmail.anchor(top: nil, bottom: nil, left: userProfileImageView.trailingAnchor, right: trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 20)
        userEmail.centerYAnchor.constraint(equalTo: userProfileImageView.centerYAnchor).isActive = true
        
        addSubview(messageContent)
        messageContent.anchor(top: userEmail.bottomAnchor, bottom: bottomAnchor, left: userProfileImageView.trailingAnchor, right: trailingAnchor, topPadding: 5, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: 0)
     
        let seperatorView = UIView()
        seperatorView.backgroundColor = .white
        addSubview(seperatorView)
        seperatorView.anchor(top: nil, bottom: bottomAnchor, left: leadingAnchor, right: trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0.4)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
