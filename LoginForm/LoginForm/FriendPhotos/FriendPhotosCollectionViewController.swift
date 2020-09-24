//
//  FriendPhotosCollectionViewController.swift
//  LoginForm
//
//  Created by Andrey on 06/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class FriendPhotosCollectionViewController: UICollectionViewController {
    
    var selectedFriend = Friend() { didSet {  allImagesURLOfAFriend = (selectedFriend.posts.compactMap{$0?.photoUrls}).flatMap{$0} } }
    
    //------

    
    var allImagesURLOfAFriend = [URL?]()

    
    //------


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        let width = (view.frame.size.width - 2 * 2 ) / 3 // TODO: put in constants
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items

        return selectedFriend.posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotoCell", for: indexPath) as! FriendPhotosCollectionViewCell

        cell.configure(for: selectedFriend.posts[indexPath.row]!)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! FriendPhotosCollectionViewCell
        
//        ----OLD
//        let postVC = storyboard?.instantiateViewController(withIdentifier: "PostFullSizeCollectionViewController") as! PostFullSizeCollectionViewController
//        postVC.selectedPost = currentCell.post
//        self.show(postVC, sender: nil)
//        ----OLD
        
        let imageVC = storyboard?.instantiateViewController(withIdentifier: "ImageScrollViewController") as! ImageScrollViewController
        
        imageVC.imageURLs = allImagesURLOfAFriend as! [URL]
        
        imageVC.selectedImageURL = currentCell.post.photoUrls.first
        
        self.show(imageVC, sender: nil)

    }
    


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
