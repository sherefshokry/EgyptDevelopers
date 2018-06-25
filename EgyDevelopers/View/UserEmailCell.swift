//
//  UserEmailCell.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/5/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit

protocol UserCellDelegate {
    func didSelectUser(email : String)
    func didUnSelectUser(email : String)
}


class UserEmailCell: UICollectionViewCell {
    
    var delegate : UserCellDelegate?
    
    var email : String? {
        didSet{
            guard let email = email else { return }
            emailLabel.text = email
        }
    }
    
    let userProfileImage : UIImageView = {
        
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "defaultProfileImage")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let emailLabel : UILabel = {
       let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    let checkMarkImage : UIImageView = {
        
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "whiteCheckmark")
        view.isHidden = true
        return view
    }()
    
    var showing  = false
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
            if showing {
                checkMarkImage.isHidden = true
                 showing = !showing
                guard let email = email else { return }
                delegate?.didUnSelectUser(email: email)
            }
            else {
                checkMarkImage.isHidden = false
                 showing = !showing
                guard let email = email else { return }
                delegate?.didSelectUser(email: email)
            }
        }
    }
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        
       addSubview(userProfileImage)
        userProfileImage.anchor(top: topAnchor, bottom: bottomAnchor, left: leadingAnchor, right: nil, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 0, width: 50, height: 0)
        userProfileImage.layer.cornerRadius = 50/2
        
        
        
        addSubview(checkMarkImage)
        
        checkMarkImage.anchor(top: nil, bottom: nil, left: nil, right: trailingAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 10, width: 18, height: 18)
         checkMarkImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSubview(emailLabel)
        
        emailLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: userProfileImage.trailingAnchor, right: checkMarkImage.leadingAnchor, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 5, width: 0, height: 0)
        
        
    }
    
 
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
