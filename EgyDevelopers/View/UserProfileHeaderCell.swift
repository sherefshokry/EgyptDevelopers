//
//  UserProfileHeaderCell.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/3/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit
import Firebase
class UserProfileHeaderCell: UICollectionViewCell {
 
    let userProfileImageView : UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "defaultProfileImage")
       view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let userEmail : UILabel = {
       let label  = UILabel()
       label.font = UIFont.boldSystemFont(ofSize: 18)
       label.textAlignment = .center
       label.textColor = UIColor.white
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.rgb(red: 65, green: 69, blue: 80)
        
        
        addSubview(userProfileImageView)
        
        userProfileImageView.anchor(top: topAnchor, bottom: nil, left: nil, right: nil, topPadding: 20, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 60, height: 60)
        userProfileImageView.layer.cornerRadius = 60/2
        userProfileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        addSubview(userEmail)
        userEmail.anchor(top: userProfileImageView.bottomAnchor, bottom: nil, left: leadingAnchor, right: trailingAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 5, rightPadding: 5, width: 0, height: 20)
    
    let seperatorLine = UIView()
    seperatorLine.backgroundColor = .white
      addSubview(seperatorLine)
        seperatorLine.anchor(top: nil, bottom: bottomAnchor, left: leadingAnchor, right: trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0.7)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
