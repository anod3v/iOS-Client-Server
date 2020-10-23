//
//  NewsFeedCollectionViewCell.swift
//  VKgram
//
//  Created by Andrey on 20/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class NewsFeedCollectionViewCell: UICollectionViewCell {
    
//    var item = Item(sourceID: Int(), date: Int(), canDoubtCategory: Bool(), canSetCategory: Bool(), topicID: Int(), postType: PostTypeEnum(rawValue: String())!, text: String(), markedAsAds: Int(), attachments: [Attachment](), postSource: PostSource(type: PostSourceType(rawValue: String())!, platform: String()), comments: Comments(count: Int(), canPost: Int(), groupsCanPost: Bool()), likes: Likes(count: Int(), userLikes: Int(), canLike: Int(), canPublish: Int()), reposts: Reposts(count: Int(), userReposted: Int()), views: Views(count: Int()), postID: Int(), type: PostTypeEnum(rawValue: String())!, categoryAction: CategoryAction(action: Action(target: String(), type: String(), url: String()), name: String()))
    
    var profileView: ProfileView = {
        let view = ProfileView()
        view.backgroundColor = .brown
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var photoCollageView: PhotoCollageView = {
        let view = PhotoCollageView()
        view.backgroundColor = .green

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var likeBarView: LikeBarView = {
        let view = LikeBarView()
        view.backgroundColor = .orange

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var postTextLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20) // TODO: to add to constants
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .systemYellow

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        print("NewsFeedCollectionViewCell frame is:", frame)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(profileView)
        addSubview(photoCollageView)
        addSubview(likeBarView)
        addSubview(postTextLabel)
    }
    
//    func configureProfileView(friend: Friend) {
//
////        print("configuring for friend:\(friend.firstName)")
//        profileView.friendName.text = "\(friend.firstName) \(friend.secondName)"
//        guard let path = friend.avatar?.path else {
//            return profileView.sourceImage.image = UIImage(named: "not found")
//        }
//        profileView.sourceImage.image = UIImage(contentsOfFile: path)
//    }
//
//    func configurePostText(postText: String) {
//        postTextLabel.text = postText
//    }
//
//    func configurePhotos(post: Post) {
//        selectedPost = post
//        photoCollageView.post = post
//        photoCollageView.collectionView.reloadData()
//        let numberOfLikes = post.numberOfLikes
//        likeBarView.likeCounterLabel.text = String(numberOfLikes)
//    }
    
    func configure(item: Item) {
//        profileView.sourceName.text = String(item.sourceID!) // TODO: for testing only
//        profileView.sourceImage = RoundImageView() // TODO: for testing only
        postTextLabel.text = item.text
        likeBarView.likeCounterLabel.text = String(item.likes?.count ?? 0)
        
        if let photos = item.attachments?.compactMap({$0?.photo})
        { photoCollageView.photos  = photos }
    
        photoCollageView.collectionView.reloadData()
    }
    
    func configureProfile(photo: String?, name: String?) {
        profileView.sourceName.text = name
        profileView.sourceImage.loadImageUsingCacheWithURLString(photo!, placeHolder: nil) { (bool) in
                    //perform actions if needed
                }
    }
    
override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
    layoutIfNeeded()
    layoutAttributes.frame.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    return layoutAttributes
}
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            profileView.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 100),

            photoCollageView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 20),
            photoCollageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoCollageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoCollageView.heightAnchor.constraint(equalTo: widthAnchor),

            likeBarView.topAnchor.constraint(equalTo: photoCollageView.bottomAnchor, constant: 20),
            likeBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            likeBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            likeBarView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),

            postTextLabel.topAnchor.constraint(equalTo: likeBarView.bottomAnchor, constant: 20),
            postTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            postTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            postTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
                
        ])
    }
    
    
}

