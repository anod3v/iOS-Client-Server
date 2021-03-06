//
//  FriendPhotosCollectionViewCell.swift
//  LoginForm
//
//  Created by Andrey on 06/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class FriendPhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var friendPhotoImage: UIImageView!
    
    @IBOutlet weak var likesNumberLabel: UILabel!
    
    @IBOutlet weak var likeButton: LikeButton!
    
    @IBOutlet weak var multiplePicSign: UIImageView!
    
    
//    var numberOfLikes = Int()
    
//    var post = Post()
    
    @IBAction func pressLikeButton(_ sender: Any) {
//        print("button is pressed")
//        if likeButton.filled {
//            numberOfLikes += 1
//            likesNumberLabel.text = String(numberOfLikes)
//        } else {
//            numberOfLikes -= 1
//            likesNumberLabel.text = String(numberOfLikes)
//        }
    }
    
    
    func configure(for model: Photo) {

        friendPhotoImage.loadImageUsingCacheWithURLString(model.photo604, placeHolder: nil) { (bool) in
            //perform actions if needed
        }
        
//        if model.photoUrls.count > 1 {
//            multiplePicSign.isHidden = false
//        } else {
//            multiplePicSign.isHidden = true
//        }
    }
}
