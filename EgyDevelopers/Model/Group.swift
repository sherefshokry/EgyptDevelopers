//
//  Group.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/6/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import Foundation


class Group {
    
    private var _groupTitle : String = ""
    private var _groupDescription : String
    private var _groupKey : String
    private var _memberCount : Int
    private var _member : [String]
    
    var groupTitle : String {
        return _groupTitle
    }
    
    var groupDescription : String {
        return _groupDescription
    }
    
    var groupKey : String {
        return _groupKey
    }
    
    var memberCount : Int {
        return _memberCount
    }
    
    var member : [String] {
        return _member
    }
    
    init(title : String , description : String , groupKey : String , memberCount : Int , member : [String]) {
        
        self._groupTitle = title
        self._groupDescription = description
        self._groupKey = groupKey
        self._memberCount = memberCount
        self._member = member
        
    }
    
    
}
