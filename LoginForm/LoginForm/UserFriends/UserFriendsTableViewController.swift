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
    
    var friends: [Friend] = []
    
    var selectedFriend = Friend () // TODO: to find a better way to init?
    
    var friendsDictionary = [String: [Friend]]()
    
    var friendSectionTitles = [String]()
    
    var searchFooter: SearchFooter!
    
    //--------------
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredFriends: [Friend] = []
    
    //--------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        friends = FriendFactory().friends
        
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
        
        tableView.reloadData()
        
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
        _ = networkService.getUserFriends(userId: Session.shared.userId!, completion: {
            (result, error) in
            debugPrint(result)
//            self.handleGetUserFriendsResponse(friend: result as! [User])
        })
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
      filteredFriends = friends.filter { (friend: Friend) -> Bool in
        return friend.firstName.lowercased().contains(searchText.lowercased()) || friend.secondName.lowercased().contains(searchText.lowercased())
      }
      
      tableView.reloadData()
        
    }
    
    func handleGetUserFriendsResponse(friend: [User]) {
        
    }
    
    func getFriendsDictionary() {
        
        var friendsToDisplay = [Friend]()
        
        friendsDictionary = [String: [Friend]]()
        
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
        let currentCell = tableView.cellForRow(at: indexPath) as! UserFriendsTableViewCell
        let friendPhotoVC = storyboard?.instantiateViewController(withIdentifier: "FriendPhotosCollectionViewController") as! FriendPhotosCollectionViewController
        friendPhotoVC.selectedFriend = currentCell.friend
//        friendPhotoVC.friends = friends
        self.show(friendPhotoVC, sender: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return friendSectionTitles[section]
    }
    
     override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendSectionTitles
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension UserFriendsTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}


