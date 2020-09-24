//
//  PostFullSizeCollectionViewCell.swift
//  LoginForm
//
//  Created by Andrey on 23/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class PostFullSizeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var pageNo: UILabel!
    
    @IBOutlet weak var rightArrow: UIImageView!
    
    @IBOutlet weak var leftArrow: UIImageView!
    
    var url = URL(string: String())
    
//    var pageNoText: String?
    
    func configure(for model: URL?) {
        url = model
        //        friendAge.text = "\(model.age)"
        guard let path = model?.path else {
            return postImage.image = UIImage(named: "not found")
        }
        postImage.image = UIImage(contentsOfFile: path)
//        numberOfLikes = model.numberOfLikes
//        likesNumberLabel.text = String(numberOfLikes)
    }
    
    func configureUIIndicators(currentIndex: Int, totalIndices: Int) {
        if totalIndices == 1 {
            pageNo.isHidden = true
            rightArrow.isHidden = true
            leftArrow.isHidden = true
        } else if currentIndex == 0 {
            pageNo.isHidden = false
            rightArrow.isHidden = false
            leftArrow.isHidden = true
            pageNo.text = "\(currentIndex + 1)/\(totalIndices)"
        } else if currentIndex == (totalIndices - 1) {
            pageNo.isHidden = false
            rightArrow.isHidden = true
            leftArrow.isHidden = false
            pageNo.text = "\(currentIndex + 1)/\(totalIndices)"
        } else {
            pageNo.text = "\(currentIndex + 1)/\(totalIndices)"
            rightArrow.isHidden = false
            leftArrow.isHidden = false
        }
    }

    
}
