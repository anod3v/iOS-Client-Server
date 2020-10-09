//
//  FriendPhotosCollectionViewController.swift
//  LoginForm
//
//  Created by Andrey on 06/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class FriendPhotosCollectionViewController: UICollectionViewController {
    
    var networkService = NetworkService()
    
    let storageService = StorageService()
    
    var selectedFriend = User(id: Int(), firstName: "", lastName: "", photo_200: "", online: Int(), trackCode: "")
    
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (view.frame.size.width - 2 * 2 ) / 3 // TODO: put in constants
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        
        _ = networkService.getUserPhotos(userId: selectedFriend.id) {
            [weak self] (result, error) in
//            debugPrint("DEBUGPRINTPHOTO:", result)
            self!.handleGetUserPhotosResponse(photos: (result?.response.items)!)
            self!.storageService.savePhotos(photos: (result?.response.items)!)
            let photos = self!.storageService.loadPhotos()
            debugPrint("photos print:", photos)
        }
        
    }
    
    func handleGetUserPhotosResponse(photos: [Photo]) {
        self.photos = photos
        DispatchQueue.main.async { self.collectionView.reloadData() }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as! FriendPhotosCollectionViewCell
        
        cell.configure(for: photos[indexPath.row])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! FriendPhotosCollectionViewCell
        
        let imageVC = storyboard?.instantiateViewController(withIdentifier: "ImageScrollViewController") as! ImageScrollViewController
        
//        imageVC.imageURLs = photos as! [URL]
        
//        imageVC.selectedImageURL = currentCell.post.photoUrls.first
//
//        self.show(imageVC, sender: nil)
        
    }
    
}
