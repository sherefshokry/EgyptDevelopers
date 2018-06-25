//
//  UserProfileCell.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/3/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit

class UserProfilePostCell: UICollectionViewCell {
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
        label.text = "Shokry@yahoo.com"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    var messageContent : UILabel = {
        let label = UILabel()
        label.text = "Message Content"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.rgb(red: 41, green: 43, blue: 52)
        
        addSubview(userProfileImageView)
        
        userProfileImageView.anchor(top: topAnchor, bottom: nil, left: leadingAnchor, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 50, height: 50)
        userProfileImageView.layer.cornerRadius = 50/2
        
        
        let stackView = UIStackView(arrangedSubviews: [userEmail, messageContent])
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        addSubview(stackView)
        
        stackView.anchor(top: topAnchor, bottom: bottomAnchor, left: userProfileImageView.trailingAnchor, right: trailingAnchor, topPadding: 10, bottomPadding: 10, leftPadding: 10, rightPadding: 10, width: 0, height: 0)
        
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
