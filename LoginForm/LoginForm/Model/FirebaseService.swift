//
//  FirebaseService.swift
//  LoginForm
//
//  Created by Andrey on 18/10/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import FirebaseDatabase

class FirebaseService: StorageServiceInterface {

    func saveHuman(userID: Int, name: String, age: Int) {
        let referenceChild = Database.database().reference().child("\(userID)")
        let value: [String : Any] = [
            "name": name,
            "age": age
        ]
        
        referenceChild.childByAutoId().setValue(value)
}

}
