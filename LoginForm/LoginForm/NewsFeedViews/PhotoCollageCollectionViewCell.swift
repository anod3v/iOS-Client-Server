//
//  PhotoCollageCollectionViewCell.swift
//  LoginForm
//
//  Created by Andrey on 30/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class PhotoCollageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    
    var label: UILabel!
    
    var url = URL(string: String())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupSubView() {
        label = UILabel(frame: .zero)
        self.addSubview(label)
        label.text = "+2"
//        label.font.withSize(CGFloat(30))
        label.textColor = .white
    }
    
    func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    //2
                    label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                    label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//                    label.widthAnchor.constraint(equalToConstant: 100),
//                    label.heightAnchor.constraint(equalToConstant: 100)

                ])
    }
    
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
    
    func addLabel() {
        setupSubView()
        setupConstraints()
    }

}
