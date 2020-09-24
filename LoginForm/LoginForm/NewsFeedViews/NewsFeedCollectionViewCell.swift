//
//  NewsFeedCollectionViewCell.swift
//  LoginForm
//
//  Created by Andrey on 29/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class NewsFeedCollectionViewCell: UICollectionViewCell {
    
    //    var friend = Friend()
    
    var selectedPost = Post()
    
    var profileView: ProfileView!
    
    var photoCollageView: PhotoCollageView!
    
    var likeBarView: LikeBarView!
    
    var postTextLabel: UILabel!
    
    var loadScreenView: LoadScreenView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureSubviews() {

        profileView = ProfileView(frame: .zero)
        profileView.backgroundColor = .white // In case I remove this line the label text will not be refreshed
        self.addSubview(profileView)
        
        photoCollageView = PhotoCollageView(frame: .zero)
        self.addSubview(photoCollageView)
        
        postTextLabel = UILabel(frame: .zero)
        postTextLabel.numberOfLines = 0
        postTextLabel.textAlignment = .natural
        postTextLabel.backgroundColor = .white // In case I remove this line the label text will not be refreshed
        self.addSubview(postTextLabel)
        
        likeBarView = LikeBarView(frame: .zero)
        likeBarView.likeCounterLabel.textColor = .link
//        likeBarView.backgroundColor = .yellow
        self.addSubview(likeBarView)
        
//        loadScreenView = LoadScreenView(frame: .zero)
//        loadScreenView.backgroundColor = .white
//        self.addSubview(loadScreenView)
        
        setupConstraints()
    }
    
    func configureProfileView(friend: Friend) {
        
        print("configuring for friend:\(friend.firstName)")
        profileView.friendName.text = "\(friend.firstName) \(friend.secondName)"
        //        friendAge.text = "\(model.age)"
        guard let path = friend.avatar?.path else {
            return profileView.friendImage.image = UIImage(named: "not found")
        }
        profileView.friendImage.image = UIImage(contentsOfFile: path)
    }
    
    func configurePhotos(post: Post) {
        selectedPost = post
        photoCollageView.post = post
        let numberOfLikes = post.numberOfLikes
        likeBarView.likeCounterLabel.text = String(numberOfLikes)
    }
    
    func configurePostText(postText: String) {
        postTextLabel.text = postText
        //        print("postTextLabel.text:\(postTextLabel.text)")
    }
    
    func setupConstraints() {
        //        profileView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        profileView.translatesAutoresizingMaskIntoConstraints = false
        photoCollageView.translatesAutoresizingMaskIntoConstraints = false
        postTextLabel.translatesAutoresizingMaskIntoConstraints = false
        likeBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            //----- laying out sub views
            profileView.friendName.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            profileView.friendImage.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            
            likeBarView.likeButton.centerYAnchor.constraint(equalTo: likeBarView.centerYAnchor),
            likeBarView.likeCounterLabel.centerYAnchor.constraint(equalTo: likeBarView.centerYAnchor),
            
            //---------
            
            profileView.topAnchor.constraint(equalTo: self.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            profileView.widthAnchor.constraint(equalToConstant: self.bounds.size.width),
            profileView.heightAnchor.constraint(equalToConstant: self.bounds.size.width / 4),
            
            //-----
            photoCollageView.topAnchor.constraint(equalTo: profileView.bottomAnchor),
            photoCollageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            photoCollageView.widthAnchor.constraint(equalToConstant: self.bounds.size.width),
            photoCollageView.heightAnchor.constraint(equalToConstant: self.bounds.size.width),
            
            //-----
            
            likeBarView.topAnchor.constraint(equalTo: photoCollageView.bottomAnchor),
            likeBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            likeBarView.widthAnchor.constraint(equalToConstant: self.bounds.size.width),
            likeBarView.heightAnchor.constraint(equalToConstant: self.bounds.size.width / 8),
            
            //-----
            postTextLabel.topAnchor.constraint(equalTo: likeBarView.bottomAnchor),
            postTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            postTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            postTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
            //-----
            
        ])
    }
    
    
}
