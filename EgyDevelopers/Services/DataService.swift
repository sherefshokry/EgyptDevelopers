//
//  DataService.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/2/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()


class DataService {
    
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USER = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    
    
    var REF_USER : DatabaseReference {
        return _REF_USER
    }
    
    
    var REF_GROUPS : DatabaseReference {
        return  _REF_GROUPS
    }
    
    var REF_FEED : DatabaseReference {
        return _REF_FEED
    }
    
    
    func createDBUser(uid : String , userData : Dictionary<String, Any>)
    {
        REF_USER.child(uid).updateChildValues(userData)
    }
    
    
    func uploadPost(withMessage message : String ,forUID uid : String ,withGroupKey groupKey : String?, sendcomplete: @escaping (_ status : Bool) -> ()){
        
        
        if groupKey != nil {
            getUserEmail(forUID: uid) { (email) in
                self._REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content" : message , "senderId" : uid , "senderEmail" : email])
             sendcomplete(true)
            }
            
        }
        else {
            getUserEmail(forUID: uid) { (email) in
                self._REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId" : uid ,"senderEmail" : email ])
             sendcomplete(true)
            }
            
        }
    }
    
    
    func createGroup(withTitle title : String ,andDescription description : String ,forUserIds uids : [String] ,completion: @escaping (_ groupCreated : Bool) -> () ){
        
        
        _REF_GROUPS.childByAutoId().updateChildValues(["title" : title , "description" : description , "members" : uids ]) { (error, refrence) in
            if let error = error {
                print("Error : " , error)
                completion(false)
                return
            }
            
            completion(true)
            
        }
        
    }
 
    
    func getUserEmail(forUID uid : String , completion : @escaping (_ userEmail : String) -> ()){
        
        _REF_USER.child(uid).observeSingleEvent(of: .value, with: { (snapShot) in
            
            guard let dictionary =  snapShot.value as?  [String : Any] else { return }
            
            guard let email = dictionary["email"] as? String  else { return }
            completion(email)
        })
        
    }
    
    
    
    func getAllFeedMessages(completion : @escaping ([Message]) -> ())
    {
        var messageArray = [Message]()
        _REF_FEED.observe(.value) { (snapshot) in
            messageArray = []
            guard let groupMessageSnapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for groupMessage in groupMessageSnapshot {
                
                let content = groupMessage.childSnapshot(forPath: "content").value as! String
                let senderId = groupMessage.childSnapshot(forPath: "senderId").value as! String
                let senderEmail = groupMessage.childSnapshot(forPath: "senderEmail").value as! String
                
                let message = Message(content: content, senderId: senderId, senderEmail: senderEmail)
                messageArray.append(message)
            }
            
            completion(messageArray)
        }
    }
            
    func getMyFeedMessages(completion : @escaping ([Message]) -> ())
    {
        var messageArray = [Message]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        _REF_FEED.observe(.value) { (snapshot) in
            messageArray = []
            guard let groupMessageSnapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for groupMessage in groupMessageSnapshot {
                
                let senderId = groupMessage.childSnapshot(forPath: "senderId").value as! String
                let content = groupMessage.childSnapshot(forPath: "content").value as! String
                let senderEmail = groupMessage.childSnapshot(forPath: "senderEmail").value as! String
               
                if senderId == uid
                {
                    
                let message = Message(content: content, senderId: senderId, senderEmail: senderEmail)
                    messageArray.append(message)
                    
                }
            } 
            completion(messageArray)
        }
    }

    
    
    func getAllMessages(forGroup group : Group , completion : @escaping (_ messages : [Message]) -> () )
    {
        var messagesArray = [Message]()
        _REF_GROUPS.child(group.groupKey).child("messages").observe(.value) { (snapshot) in
      
            messagesArray = []
            guard let groupMessageSnapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for groupMessage in groupMessageSnapshot {
                
                let content = groupMessage.childSnapshot(forPath: "content").value as! String
                let senderId = groupMessage.childSnapshot(forPath: "senderId").value as! String
                let senderEmail = groupMessage.childSnapshot(forPath: "senderEmail").value as! String
                
                let message = Message(content: content, senderId: senderId, senderEmail: senderEmail)
                messagesArray.append(message)
            }
            
            completion(messagesArray)
            
        }
        
        
    }
    
    func  getEmail (forSearchQuery query : String , completion : @escaping (_ emailArray : [String]) -> ())
    {
        var emailArray = [String]()
        
        _REF_USER.observe(.value) { (snapshot) in
           
            emailArray = []
            guard let emailSnapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for email in emailSnapshot {
              
                guard let email = email.childSnapshot(forPath: "email").value as? String else { return }
                
                if email.uppercased().contains(query.uppercased()) == true && email != Auth.auth().currentUser?.email
                {
                    
                    emailArray.append(email)
                }
  
            }
        
            completion(emailArray)
        }
        
        
    }
    
    
    func getIds (forUserEmails userEmails : [String] , completion: @escaping (_ uidArray: [String]) -> () )
    {
        var uidArray = [String]()
        _REF_USER.observeSingleEvent(of: .value) { (snapshot) in
           
            guard let uidsSnapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for uid in uidsSnapshot {
        
               guard let email = uid.childSnapshot(forPath: "email").value as? String else { return }
  
                if userEmails.contains(email)
                {
                    uidArray.append(uid.key)
                }
                
            }
            completion(uidArray)
        }
    }
    
    
    func getEmails (withGroup group : Group , completion : @escaping (_ emails: [String]) -> () )
    {
        var emailsArray = [String]()
        _REF_USER.observeSingleEvent(of: .value) { (snapshot) in
            
            guard let usersSnapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in usersSnapshot {
                
            
                if group.member.contains(user.key)
                {
                    guard let userEmail = user.childSnapshot(forPath: "email").value as? String  else { return }
                    emailsArray.append(userEmail)
                }
                
            }
            completion(emailsArray)
            
        }
    }
    
    
   
    func getGroups(completion : @escaping (_ groups : [Group]) -> ()){
      
        var groupsArray = [Group]()
        
        _REF_GROUPS.observe(.value) { (snapshot) in

            groupsArray = []
            guard let groupsSnapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for group in groupsSnapshot {
                
                
               guard let memberArray = group.childSnapshot(forPath: "members").value as? [String]
                else { return }
               
                if memberArray.contains((Auth.auth().currentUser?.uid)!){
               
                    guard let title = group.childSnapshot(forPath: "title").value as? String else { return }
                    guard let description = group.childSnapshot(forPath: "description").value as? String else { return }
                    let key = group.key
                
                    let group = Group(title: title, description: description, groupKey: key, memberCount: memberArray.count, member: memberArray)
                    groupsArray.append(group)
                }
            }
            
            completion(groupsArray)
            
        }
        }
 
}
