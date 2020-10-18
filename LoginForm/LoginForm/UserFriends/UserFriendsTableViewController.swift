//
//  UserFriendsTableViewController.swift
//  LoginForm
//
//  Created by Andrey on 05/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit


class UserFriendsTableViewController: UITableViewController {
    
    var networkService = NetworkService()
    
    var storageService = StorageService()
    
    let firebaseService = FirebaseService()
    
    var friends = [User]()
    
    var selectedFriend = User(id: Int(), firstName: "", lastName: "", photo_200: "", trackCode: "") // TODO: to find a better way to init?
    
    var friendsDictionary = [String: [User]]()
    
    var friendSectionTitles = [String]()
    
    var searchFooter: SearchFooter!
    
    //--------------
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredFriends: [User] = []
    
    //--------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = networkService.getUserFriends(userId: Session.shared.userId!) {
            [weak self] (result, error) in
//            debugPrint("DEBUGPRINT:", result)
            self!.handleGetUserFriendsResponse(friends: (result?.response.items)!)
        }
        
        getFriendsDictionary()
        
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Friends"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        searchFooter = SearchFooter()
        
        self.view.addSubview(searchFooter)
        
//        _ = networkService.getUserInfo(userId: 616595796, completion: {
//            (result, error) in
//            debugPrint("the result is:", result)
//        })
//
//        _ = networkService.getUserGroups(userId: Session.shared.userId!, completion: {
//            result in
//            debugPrint(result)
//        })
//
//        _ = networkService.getUserPhotos(userId: 616595781, completion: {
//            result in
//            debugPrint(result)
//        })
//
//
//        _ = networkService.searchGroups(queryText: "music", completion: {
//            result in
//            debugPrint(result)
//        })
        
    }
    
    //--------
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
      return searchController.isActive && (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredFriends = friends.filter { (friend: User) -> Bool in
        return friend.firstName.lowercased().contains(searchText.lowercased()) || friend.lastName.lowercased().contains(searchText.lowercased())
      }
      
      tableView.reloadData()
        
    }
    
    func handleGetUserFriendsResponse(friends: [User]) {
        self.storageService.saveUsers(users: friends)
        self.friends = self.storageService.loadUsers()
//        debugPrint("users print:", self.friends)
//        self.firebaseService.saveUserFriends(userID: Session.shared.userId!, friendIDs: friends.compactMap({$0.id}))
        self.firebaseService.saveUserFriends(userID: Session.shared.userId!, friends: friends)
        DispatchQueue.main.async { self.tableView.reloadData() }
    }
    
    func getFriendsDictionary() {
        
        var friendsToDisplay = [User]()
        
        friendsDictionary = [String: [User]]()
        
        friendSectionTitles = [String]()
        
        if isFiltering {
          friendsToDisplay = filteredFriends
        } else {
          friendsToDisplay = friends
        }
        
        for friend in friendsToDisplay {
            let friendKey = String(friend.firstName.prefix(1))
                if var friendValues = friendsDictionary[friendKey] {
                    friendValues.append(friend)
                    friendsDictionary[friendKey] = friendValues
                } else {
                    friendsDictionary[friendKey] = [friend]
                }
            
            friendSectionTitles = [String](friendsDictionary.keys)
            friendSectionTitles = friendSectionTitles.sorted(by: { $0 < $1 })
            
        }
        
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        getFriendsDictionary()
        return friendSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friendKey = friendSectionTitles[section]
        if let friendValues = friendsDictionary[friendKey] {
            return friendValues.count
        }
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! UserFriendsTableViewCell
        
        let friendKey = friendSectionTitles[indexPath.section]
        if let friendValues = friendsDictionary[friendKey] {
            cell.configure(for: friendValues[indexPath.row])
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserFriendsTableViewCell
        let friendPhotoVC = storyboard?.instantiateViewController(withIdentifier: "FriendPhotosCollectionViewController") as! FriendPhotosCollectionViewController
        friendPhotoVC.selectedFriend = cell.friend
        self.show(friendPhotoVC, sender: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendSectionTitles[section]
    }
    
     override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendSectionTitles
    }
    
}

extension UserFriendsTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}


