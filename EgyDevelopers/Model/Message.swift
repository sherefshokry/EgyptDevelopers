//
//  Post.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/2/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import Foundation


class Message {
    
    private var _content : String
    private var _senderId : String
    private var _senderEmail : String
    var content : String {
        return _content
    }
    
    var senderId : String {
        return _senderId
    }
    
    var senderEmail : String {
        return _senderEmail
    }
    
    
    init(content : String , senderId : String , senderEmail : String) {
        self._content = content
        self._senderId = senderId
        self._senderEmail = senderEmail
    }
    
}
