//
//  GroupChatController.swift
//  EgyDevelopers
//
//  Created by SherifShokry on 6/2/18.
//  Copyright © 2018 SherifShokry. All rights reserved.
//

import UIKit

class GroupChatController: UICollectionViewController , UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    var groups = [Group]()
    override func viewDidLoad()
    {
        super.viewDidLoad()

    
   collectionView?.backgroundColor = UIColor.rgb(red: 65, green: 69, blue: 80)
    setupNavigationItems()
   
        
        collectionView?.register(GroupCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.alwaysBounceVertical = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.getGroups { (returnedGroups) in
            self.groups = returnedGroups
            self.collectionView?.reloadData()
        }
    
    }
    
    
    
    
    func setupNavigationItems() {
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.green]
        self.navigationItem.title = "_groups"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "addNewIcon"), style: .plain, target: self, action: #selector(handleAddGroup))
        
    }
    
    @objc func handleAddGroup() {
    
       let createGroup = CreateGroupController()
        present(createGroup, animated: true, completion: nil)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? GroupCell else { return UICollectionViewCell() }
        cell.group = groups[indexPath.item]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
   
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       let groupFeedController = GroupFeedController()
        groupFeedController.group = groups[indexPath.item]
       present(groupFeedController, animated: true, completion: nil)
  
    }

}
