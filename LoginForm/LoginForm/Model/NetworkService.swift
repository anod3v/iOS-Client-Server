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
    
    func getUserInfo(userId: Int, completion: @escaping (Response?, Error?) -> Void) {
        
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
                
                let result = try decoder.decode(Response.self, from: dataResponse)
                debugPrint("result:", result)
                completion(result, nil)
                
            } catch (let error) {
                
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
    
    func getUserPhotos(userId: Int, callback: @escaping (PhotoWelcome?, Error?) -> Void) {
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
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(userId)"),
            URLQueryItem(name: "count", value: "200"),
            URLQueryItem(name: "access_token", value: "\(token)"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        debugPrint(urlConstructor.url!)
        
        let decoder = JSONDecoder()
        
        // задача для запуска
         let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
                   
                   let jsonData = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                   debugPrint("jsonData:", jsonData)
                   
                   guard let dataResponse = data, error == nil else {
                       debugPrint(error?.localizedDescription ?? "Response Error")
                       return }
                   
                   do {
                       
                       let result = try decoder.decode(PhotoWelcome.self, from: dataResponse)
                       debugPrint("result:", result)
                       callback(result, nil)
                       
                   } catch (let error) {
                       
                       callback(nil, error)
                   }
               }
               
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
    
    func getUserFriends(userId: Int, callback: @escaping (Welcome?, Error?) -> Void) {
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
            URLQueryItem(name: "fields", value: "photo_200"),
            URLQueryItem(name: "access_token", value: "\(token)"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        debugPrint(urlConstructor.url!)
        
        let decoder = JSONDecoder()
        
        // задача для запуска
         let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
                   
                   let jsonData = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                   debugPrint("jsonData:", jsonData)
                   
                   guard let dataResponse = data, error == nil else {
                       debugPrint(error?.localizedDescription ?? "Response Error")
                       return }
                   
                   do {
                       
                       let result = try decoder.decode(Welcome.self, from: dataResponse)
                       debugPrint("result:", result)
                       callback(result, nil)
                       
                   } catch (let error) {
                       
                       callback(nil, error)
                   }
               }
               
               task.resume()
        
        //-----
    }
  
    
}


  // MARK: - Welcome
  struct Welcome: Decodable {
      let response: Response
  }

  // MARK: - Response
  struct Response: Decodable {
      let count: Int
      let items: [User]
  }

  // MARK: - Item
  struct User: Decodable {
      let id: Int
      let firstName, lastName: String
      let photo_200: String
      let online: Int
      let trackCode: String

      enum CodingKeys: String, CodingKey {
          case id
          case firstName = "first_name"
          case lastName = "last_name"
          case photo_200 = "photo_200"
          case online
          case trackCode = "track_code"
      }
  }

struct PhotoWelcome: Codable {
    let response: PhotoResponse
}

// MARK: - Response
struct PhotoResponse: Codable {
    let count: Int
    let items: [Photo]
}

// MARK: - Item
struct Photo: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let height: Int
    let photo1280, photo130, photo2560, photo604: String
    let photo75, photo807: String
    let text: String
    let width: Int
    let postID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case height
        case photo1280 = "photo_1280"
        case photo130 = "photo_130"
        case photo2560 = "photo_2560"
        case photo604 = "photo_604"
        case photo75 = "photo_75"
        case photo807 = "photo_807"
        case text, width
        case postID = "post_id"
    }
}
  
