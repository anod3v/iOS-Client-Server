//
//  FriendFactory.swift
//  VKgram
//
//  Created by Andrey on 17/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

class FriendFactory {
    
    init() {
        getFriends()
        configureFriends()
    }
    
    var friends: [Friend] = []
    
    // MARK: - Data parsing and configuration
    
    func getFriends() {
        
        let dataArray = parseDataFromFiles()
        
        for item in dataArray {
            
            guard item.FileType != "txt" else { continue }
            
            if !friends.contains(where: {$0.firstName == item.firstName && $0.secondName == item.secondName}) {
                
                let friend = Friend(firstName: item.firstName, secondName: item.secondName)
                friends.append(friend)
                
            }
        }
    }
    
    func configureFriends() {
        for index in friends.indices {
            getFriendAvatar(friend: &friends[index])
            getFriendPostPhotos(friend: &friends[index])
            getFriendPostText(friend: &friends[index])
            getFriendPostLikes(friend: &friends[index])
        }
    }
    
    
    func getFriendAvatar(friend: inout Friend) {
        
        let dataArray = parseDataFromFiles()
        
        for item in dataArray {
        
        guard item.FileType != "txt" else { continue }
            
            if item.postNo == 0 &&
                friend.firstName == item.firstName &&
                friend.secondName == item.secondName {
                friend.avatar = item.URL
                
            }
        }
    }
    
    func getFriendPostPhotos(friend: inout Friend) {
        
        let dataArray = parseDataFromFiles()
        
        for item in dataArray {
            
            guard item.FileType != "txt" else { continue }
            guard item.postNo != 0 else { continue }
            guard friend.firstName == item.firstName && friend.secondName == item.secondName else { continue }
            
            if !friend.posts.contains(where: {$0?.postNo == item.postNo}) {
                let newPost = Post(authorID: friend.identifier!, postNo: item.postNo!, photoUrls: [item.URL])
                friend.posts.append(newPost)
            } else {
                let index = friend.posts.firstIndex(where: {$0?.postNo == item.postNo})
                friend.posts[index!]?.photoUrls.append(item.URL)
            }
        }
    }
    
    func getFriendPostText (friend: inout Friend) {
        
        let dataArray = parseDataFromFiles()
        
        for item in dataArray {
            
            guard item.FileType == "txt" else { continue }
            
            guard friend.firstName == item.firstName &&
                friend.secondName == item.secondName else { continue }
            
            for index in friend.posts.indices {
                guard item.postNo == friend.posts[index]?.postNo else { continue }
                do {
                let contents = try String(contentsOfFile: item.URL.path)
                    friend.posts[index]?.postText = contents
                } catch {
                    // contents could not be loaded
                }
            }
        }
    }
    
    func getFriendPostLikes (friend: inout Friend) {
        
        let rangeOfLikes = 0...1000
        
        let dataArray = parseDataFromFiles()
        
        for _ in dataArray {
            for index in friend.posts.indices {
                let randomNumber = rangeOfLikes.randomElement()
                friend.posts[index]?.numberOfLikes = randomNumber!
            }
        }
    }
    
    func parseDataFromFiles() -> [(firstName: String, secondName: String, postNo: Int?, postItemNo: Int?, FileType: String, URL: URL)] {
        
        var dataArray = [(firstName: String, secondName: String, postNo: Int?, postItemNo: Int?, FileType: String, URL: URL)]()
        
        func getUrls() -> [URL]? {
            let bundle = Bundle.main.url(forResource: "datasource", withExtension: "bundle")!
            let fileManager = FileManager()
            let arrayOfUrls = try? fileManager.contentsOfDirectory(at: bundle, includingPropertiesForKeys: nil, options: [])
            return arrayOfUrls
        }
        
        let arrayOfUrls = getUrls()
        
        for url in arrayOfUrls! {
            
            let fullFileName = url.lastPathComponent.components(separatedBy: ".")
            
            let splitFileName = fullFileName[0].components(separatedBy: "_")
            
            guard splitFileName.count == 4 else { continue }
            
            let newElement = (firstName: splitFileName[0],
                              secondName: splitFileName[1],
                              postNo: Int(splitFileName[2]),
                              postItemNo: Int(splitFileName[3]),
                              FileType: fullFileName[1],
                              URL: url)
            
            dataArray.append(newElement)
            
        }
        return dataArray
    }
    
    
}

