//
//  UserProfileController.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/2/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController , UICollectionViewDelegateFlowLayout {

    
    let cellId = "cellId"
    let headerId = "headerId"
     var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

          collectionView?.backgroundColor  = UIColor.rgb(red: 65, green: 69, blue: 80)
       
        
        collectionView?.register(UserProfileHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        collectionView?.register( UserProfilePostCell.self, forCellWithReuseIdentifier: cellId)
        

        
        collectionView?.alwaysBounceVertical = true 
        setupNavigationItems()
    }

   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        DataService.instance.getMyFeedMessages { (messagesArray) in
            self.messages = messagesArray.reversed()
            self.collectionView?.reloadData()
        }
        
    }
    
   

    func setupNavigationItems() {
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.green]
        self.navigationItem.title = "_me"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logoutIcon"), style: .plain, target: self, action: #selector(handleLogOut))
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let dummyCell = GroupFeedCell(frame: frame)
        
        dummyCell.message = messages[indexPath.item]
        dummyCell.layoutIfNeeded()
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize =  dummyCell.systemLayoutSizeFitting(targetSize)
        
        let height = max(55, estimatedSize.height)
 
        
    return CGSize(width: view.frame.width , height: height)
   }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as?  UserProfilePostCell else { return UICollectionViewCell() }
            
        cell.message = messages[indexPath.item]
        
        return cell
       
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! UserProfileHeaderCell
         header.userEmail.text = Auth.auth().currentUser?.email 
         return header
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width , height: 180)
    }

    
    
    
    
    
}
