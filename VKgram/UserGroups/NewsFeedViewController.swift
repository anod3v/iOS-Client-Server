//
//  NewsFeedViewController.swift
//  VKgram
//
//  Created by Andrey on 20/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    var networkService = NetworkService()
    
    var newFeedItems = [Item]()
    
    var newsFeedGroups = [Group]()
    
    var newsFeedProfiles = [Profile]()
    
    var photos = [AttachmentPhoto]()
    
    var profilesOfGroups = [ProfileInterface]()
    
    var collectionView: UICollectionView = {
        let layout = NewsFeedFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 375, height: 800)
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.systemRed
        collection.isScrollEnabled = true
        collection.contentInsetAdjustmentBehavior = .always
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let cellID = "NewsFeedCollectionViewCell"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        _ = networkService.getNewsFeedItems( callback: { // TODO: to check with swiftbook how they optimized this request
            [weak self] (result, error) in
            debugPrint("the result is:", result)
            self!.handleGetNewsFeedResponse(response: ((result?.response)!))
        })
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewsFeedCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.pin(to: view)
        
    }
    
    func handleGetNewsFeedResponse(response: Response) {
        self.newFeedItems = response.items
        self.newsFeedGroups = response.groups
        self.newsFeedProfiles = response.profiles
        
        DispatchQueue.main.async { self.collectionView.reloadData() }
    }
    
}


extension NewsFeedViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newFeedItems.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! NewsFeedCollectionViewCell
        
        let item = newFeedItems[indexPath.row]
        
        if item.sourceID! >= 0 {
            profilesOfGroups = newsFeedProfiles
        } else {
            profilesOfGroups = newsFeedGroups
        }
        
        let positiveSourceId = item.sourceID! >= 0 ? item.sourceID : (item.sourceID! * -1)
        
        let dataToDisplay = profilesOfGroups.first(where: {$0.id == positiveSourceId })
        
        cell.configure(item: item)
        cell.configureProfile(photo: dataToDisplay!.photo, name: dataToDisplay!.name)
        
        return cell
    }
    
}
