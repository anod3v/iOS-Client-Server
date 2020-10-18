//
//  StorageInterface.swift
//  LoginForm
//
//  Created by Andrey on 18/10/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

protocol StorageServiceInterface {
    func saveHuman(name: String, age: Int)
    func readHumabList() -> [HumanEntity]
    func readHumabList(callback: @escaping ([HumanEntity]) -> Void)
}
