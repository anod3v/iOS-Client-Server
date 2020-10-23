//
//  UserFriendsViewController.swift
//  VKgram
//
//  Created by Andrey on 12/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class UserFriendsViewController: UIViewController {
    
    var tableView = UITableView()
    
    var friends = [Friend]()
    
    var cellID = "UserFriendsTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        friends = FriendFactory().friends
        title = "Friends"
        view.backgroundColor = .red
        configureTableView()
        setTableViewDelegates()
        // Do any additional setup after loading the view.
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.rowHeight = 100
        tableView.register(UserFriendsTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserFriendsTableViewCell
        let friendPostsViewController = FriendPostsViewController()
        friendPostsViewController.selectedFriend = cell.selectedFriend
        friendPostsViewController.modalPresentationStyle = .fullScreen
        self.present(friendPostsViewController, animated: true, completion: nil)
        
    }
}

extension UserFriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! UserFriendsTableViewCell
        let friend = friends[indexPath.row]
        cell.configure(for: friend)
        
        return cell
    }
    
    
}
