//
//  UserFriendsTableViewCell.swift
//  LoginForm
//
//  Created by Andrey on 05/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class UserFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var friendImage: RoundImageView!
    @IBOutlet weak var friendName: UILabel!

    var friend = Friend()
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        // Initialization code
//
//        let imageContainer = UIView(frame: friendImage.bounds)
////        let myImage = UIImageView(frame: friendImage.bounds)
////        myImage.backgroundColor != .clear
//        imageContainer.clipsToBounds = false
//        imageContainer.layer.masksToBounds = false
//        imageContainer.layer.shadowColor = UIColor.black.cgColor
//        imageContainer.layer.shadowOpacity = 0.5
//        imageContainer.layer.shadowOffset = CGSize.zero
//        imageContainer.layer.shadowRadius = 8
////        myImage.layer.shadowPath = UIBezierPath(roundedRect: myImage.bounds, cornerRadius: myImage.frame.size.height / 2).cgPath
////        myImage.layer.cornerRadius = 8
//
////        friendImage.frame = imageContainer.bounds
////        friendImage.layer.masksToBounds = false
////        friendImage.layer.shadowColor = UIColor.black.cgColor
////        friendImage.layer.shadowOpacity = 1
////        friendImage.layer.shadowOffset = CGSize.zero
////        friendImage.layer.shadowRadius = 8
//        friendImage.clipsToBounds = true
//        friendImage.layer.cornerRadius = friendImage.frame.size.height / 2
//
//        imageContainer.layer.shadowPath = UIBezierPath(roundedRect: imageContainer.bounds, cornerRadius: friendImage.frame.size.height / 2).cgPath
//
//        imageContainer.addSubview(friendImage)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(for model: Friend) {
        friendName.text = "\(model.firstName) \(model.secondName)"
        friend = model
//        friendAge.text = "\(model.age)"
        guard let path = model.avatar?.path else {
            return friendImage.image = UIImage(named: "not found")
        }
        friendImage.image = UIImage(contentsOfFile: path)
    }

}
