//
//  Friend.swift
//  VKgram
//
//  Created by Andrey on 17/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

struct Friend {
    let firstName: String
    let secondName: String
    var avatar: URL?
    var posts: [Post?]
    
    var identifier: Int? // we use identifier to pass the information on friend identity to various destinations including views
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
        
    }
    
    init(firstName: String, secondName: String) {
        self.firstName = firstName
        self.secondName = secondName
        self.identifier = Friend.getUniqueIdentifier()
        self.posts = [Post?]()
    }
    
    init() {
        self.firstName = ""
        self.secondName = ""
        self.identifier = nil
        self.posts = [Post?]()
    }
}
