//
//  StorageService.swift
//  LoginForm
//
//  Created by Andrey on 04/10/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class StorageService {
    
    let coreDataStack = CoreDataStack(modelName: "CoreDataModel")
    
    func saveUsers(users:[User]) {
        let context = coreDataStack.persistentContainer.viewContext
        for user in users {
            let localUser = LocalUser(context: context)
            localUser.id = Int64(user.id)
            localUser.firstName = user.firstName
            localUser.lastName = user.lastName
            localUser.online = Int16(user.online)
            localUser.trackCode = user.trackCode
            localUser.photo_200 = user.photo_200
            coreDataStack.saveContext()
        }
    }
    
    func loadUsers() -> [User] {
        let context = coreDataStack.persistentContainer.viewContext
        var users = [User]()
        let localUsers = (try? context.fetch(LocalUser.fetchRequest()) as? [LocalUser] ?? [])
        for localUser in localUsers! {
            let user = User(id: Int(localUser.id),
                            firstName: localUser.firstName!,
                            lastName: localUser.lastName!,
                            photo_200: localUser.photo_200!,
                            online: Int(localUser.online),
                            trackCode: localUser.trackCode!)
            users.append(user)
        }
        return users
    }
    
    func savePhotos(photos:[Photo]) {
        let context = coreDataStack.persistentContainer.viewContext
        let localPhoto = LocalPhoto(context: context)
        for photo in photos {
            localPhoto.id = Int16(photo.id)
            localPhoto.albumID = Int16(photo.albumID)
            localPhoto.date = Int16(photo.date)
            localPhoto.hasTags = photo.hasTags
            localPhoto.height = Int16(photo.height)
            localPhoto.ownerID = Int64(photo.ownerID)
            localPhoto.photo130 = photo.photo130
            localPhoto.photo604 = photo.photo604
            localPhoto.photo75 = photo.photo75
            localPhoto.photo807 = photo.photo807
            localPhoto.text = photo.text
            localPhoto.width = Int16(photo.width)
            coreDataStack.saveContext()
        }
    }
    
    func loadPhotos() -> [Photo] {
        let context = coreDataStack.persistentContainer.viewContext
        var photos = [Photo]()
        let localPhotos = (try? context.fetch(LocalPhoto.fetchRequest()) as? [LocalPhoto] ?? [])
        for localPhoto in localPhotos! {
        let photo = Photo(albumID: Int(localPhoto!.albumID),
                          date: Int(localPhoto!.date),
                          id: Int(localPhoto!.id),
                          ownerID: Int(localPhoto!.ownerID),
                          hasTags: localPhoto!.hasTags,
                          height: Int(localPhoto!.height),
                          photo130: localPhoto!.photo130!,
                          photo604: localPhoto!.photo604!,
                          photo75: localPhoto!.photo75!,
                          photo807: localPhoto!.photo807!,
                          text: localPhoto!.text!,
                          width: Int(localPhoto!.width))
            photos.append(photo)
        }
        return photos
    }
}
