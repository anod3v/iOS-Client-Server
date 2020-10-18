//
//  FirebaseService.swift
//  LoginForm
//
//  Created by Andrey on 18/10/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import FirebaseDatabase

class FirebaseService {

    func saveUser(userID: Int) {
        let referenceChild = Database.database().reference().child("Users")
        let value = userID
        
        referenceChild.setValue(value)
}
    func saveUserFriends(userID:Int, friends:[User]) {
        let referenceChild = Database.database().reference().child("Users")
        var values = [[String : Any]]()
        for friend in friends {
        let value: [String : Any] = [
            "id" : friend.id,
            "firstName" : friend.firstName,
            "lastName" : friend.lastName
            ]
            values.append(value)
        }
        referenceChild.child("\(userID)").child("user's friends").setValue(values)
    }

}
