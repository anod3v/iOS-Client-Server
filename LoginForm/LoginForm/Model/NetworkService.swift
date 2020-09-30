//
//  NetworkService.swift
//  LoginForm
//
//  Created by Andrey on 26/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation

class NetworkService {
    
    func getLoginForm() -> URLRequest {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7609893"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        return request
        
    }
    
    func getUserInfo(userId: Int, completion: @escaping (User?, Error?) -> Void) {
        
        guard let token = Session.shared.token else { return }
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // создаем конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/users.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_ids", value: "\(userId)"),
            URLQueryItem(name: "fields", value: "bdate"),
            URLQueryItem(name: "access_token", value: "\(token)"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let decoder = JSONDecoder()
        
//        debugPrint("urlConstructor.url!:", urlConstructor.url!)
        
        // задача для запуска
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            debugPrint("jsonData:", jsonData)
            
            guard let dataResponse = data, error == nil else {
                debugPrint(error?.localizedDescription ?? "Response Error")
                return }
            
            do {
                
                let result = try decoder.decode(User.self, from: dataResponse)
                completion(result, nil)
                
            } catch(let error) {
                
                completion(nil, error)
            }
        }
        
        task.resume()
        
        //-----
    }
    
    func getUserGroups(userId: Int, completion: @escaping (Any?) -> Void) {
        
        guard let token = Session.shared.token else { return }
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // создаем конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(userId)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: "\(token)"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        
        // задача для запуска
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            completion(json)
        }
        // запускаем задачу
        task.resume()
        
        //-----
    }
    
    func getUserPhotos(userId: Int, completion: @escaping (Any?) -> Void) {
        //-----
        guard let userId = Session.shared.userId else { return }
        guard let token = Session.shared.token else { return }
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // создаем конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(userId)"),
            URLQueryItem(name: "album_id", value: "wall"),
            URLQueryItem(name: "count", value: "1000"),
            URLQueryItem(name: "access_token", value: "\(token)"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        debugPrint("urlConstructor.url!:", urlConstructor.url!)
        
        // задача для запуска
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            completion(json)
            
        }
        // запускаем задачу
        task.resume()
        
        //-----
    }
    
    func searchGroups(queryText: String, completion: @escaping (Any?) -> Void) {
        
        guard let userId = Session.shared.userId else { return }
        guard let token = Session.shared.token else { return }
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // создаем конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.search"
        urlConstructor.queryItems = [
            URLQueryItem(name: "q", value: "\(queryText)"),
            URLQueryItem(name: "access_token", value: "\(token)"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        // задача для запуска
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            completion(json)
        }
        // запускаем задачу
        task.resume()
        
        //-----
    }
    
    func getUserFriends(userId: Int, completion: @escaping (Any?) -> Void) {
        //-----
        
        guard let token = Session.shared.token else { return }
        
        // Конфигурация по умолчанию
        let configuration = URLSessionConfiguration.default
        
        // собственная сессия
        let session =  URLSession(configuration: configuration)
        
        // создаем конструктор для URL
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: "\(userId)"),
            URLQueryItem(name: "count", value: "5000"),
            URLQueryItem(name: "access_token", value: "\(token)"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        // задача для запуска
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            // в замыкании данные, полученные от сервера, мы преобразуем в json
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            completion(json)
        }
        // запускаем задачу
        task.resume()
        
        //-----
    }
    
    struct User: Decodable {
        let id: Int
        let first_name: String
        let last_name: String
        let bdate: String
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try values.decode(Int.self, forKey: .id)
            self.first_name = try values.decode(String.self, forKey: .first_name)
            self.last_name = try values.decode(String.self, forKey: .last_name)
            self.bdate = try values.decode(String.self, forKey: .bdate)
            //
            //            let mainValues = try values.nestedContainer(keyedBy: CoordKeys.self, forKey: .main)
            //            self.temp = try mainValues.decode(Double.self, forKey: .temperature)
            //
            //            let windValues = try values.nestedContainer(keyedBy: CoordKeys.self, forKey: .wind)
            //            self.speed = try windValues.decode(Double.self, forKey: .speed)
            
        }
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id, first_name, last_name, bdate
    }
    
}
