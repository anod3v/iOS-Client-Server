//
//  Post.swift
//  VKgram
//
//  Created by Andrey on 17/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

struct Post {
    let authorID: Int
    var postNo: Int
    var numberOfLikes: Int
    var postText: String?
    var photoUrls: [URL]
    
    init(authorID: Int, postNo: Int, photoUrls: [URL]) {
        self.authorID = authorID
        self.postNo = postNo
        self.photoUrls = photoUrls
        self.numberOfLikes = 0
        self.postText = nil
    }
    
    init() {
        self.authorID = Int()
        self.postNo = Int()
        self.photoUrls = []
        self.numberOfLikes = Int()
        self.postText = nil
    }
}
