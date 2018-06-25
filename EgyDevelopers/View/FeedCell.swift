//
//  FeedCell.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/3/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
   
    var message : Message? {
        didSet{
            guard let content = message?.content else { return }
            guard let email = message?.senderEmail else { return }
          
            userEmail.text = email
            messageContent.text = content
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
   
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
