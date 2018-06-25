//
//  GroupCell.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/6/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit

class GroupCell: UICollectionViewCell {
    
    var group : Group? {
        didSet{
            guard let group = group else { return }
          groupTitle.text = group.groupTitle
          groupDescription.text = group.groupDescription
          membersCount.text = "\(group.memberCount) members." 
            
        }
    }
    
    
    let groupTitle : UILabel = {
        let label = UILabel()
        label.text = "Group Title"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let groupDescription : UILabel = {
        let label = UILabel()
        label.text = "this descripe our group purpose"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    let membersCount : UILabel = {
        let label = UILabel()
        label.text = "3 members."
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
       
      backgroundColor = UIColor.rgb(red: 41, green: 43, blue: 52)
        
        
        let stackView = UIStackView(arrangedSubviews: [groupTitle,groupDescription,membersCount])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        
        stackView.anchor(top: topAnchor, bottom: bottomAnchor, left: leadingAnchor, right: trailingAnchor, topPadding: 5, bottomPadding: 5, leftPadding: 5, rightPadding: 5, width: 0, height: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
