//
//  HomeFeedController.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/2/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit



class HomeFeedController: UICollectionViewController , UICollectionViewDelegateFlowLayout {

   private let cellId = "cellId"
   var messages = [Message]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
      collectionView?.backgroundColor = UIColor.rgb(red: 65, green: 69, blue: 80)
        
       
        
        self.collectionView!.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        
        setupNavigationItems()
        
        collectionView?.alwaysBounceVertical = true
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        DataService.instance.getAllFeedMessages { (messagesArray) in
            self.messages = messagesArray.reversed()
            self.collectionView?.reloadData()
        }

    }
    
 
    func setupNavigationItems() {
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.green]
        self.navigationItem.title = "_feed"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "compose"), style: .plain, target: self, action: #selector(handleNewFeed))
     
    }
    
    @objc func handleNewFeed() {
        let postController = SharePostController()
        present(postController, animated: true, completion: nil)
    }
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        cell.message  = messages[indexPath.item]
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    

}
