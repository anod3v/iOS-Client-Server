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

//    var friend = LocalUser(id: Int(), firstName: "", lastName: "", photo_200: "", trackCode: "")
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(for model: LocalUser) {
        friendName.text = "\(model.firstName!) \(model.lastName!)"
//        friend = model
        friendImage.loadImageUsingCacheWithURLString(model.photo_200!, placeHolder: nil) { (bool) in
            //perform actions if needed
        }
    }

}
