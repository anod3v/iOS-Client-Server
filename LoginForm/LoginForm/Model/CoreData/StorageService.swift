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
    
    
}
