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
    
    
    var numberOfLikes = Int()
    
    var post = Post()
    
    @IBAction func pressLikeButton(_ sender: Any) {
//        print("button is pressed")
        if likeButton.filled {
            numberOfLikes += 1
            likesNumberLabel.text = String(numberOfLikes)
        } else {
            numberOfLikes -= 1
            likesNumberLabel.text = String(numberOfLikes)
        }
    }
    
    
    func configure(for model: Post) {
        post = model
        //        friendAge.text = "\(model.age)"
        guard let path = model.photoUrls.first?.path else {
            return friendPhotoImage.image = UIImage(named: "not found")
        }
        friendPhotoImage.image = UIImage(contentsOfFile: path)
        numberOfLikes = model.numberOfLikes
        likesNumberLabel.text = String(numberOfLikes)
        
        if model.photoUrls.count > 1 {
            multiplePicSign.isHidden = false
        } else {
            multiplePicSign.isHidden = true
        }
    }
}
