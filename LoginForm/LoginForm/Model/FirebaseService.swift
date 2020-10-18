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
    func saveUserFriends(userID:Int, friendIDs:[Int]) {
        let referenceChild = Database.database().reference().child("Users")
        let value: [Int] = friendIDs
        
        referenceChild.child("\(userID)").child("user's friends IDs").setValue(friendIDs)
    }

}
