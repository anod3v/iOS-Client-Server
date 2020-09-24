//
//  NewsFeedViewController.swift
//  LoginForm
//
//  Created by Andrey on 29/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var friends: [Friend] = []
    
    var allPosts: [Post?] = []
    
    var shuffledPosts: [Post?] = []
    
    @IBOutlet weak var newsFeedCollectionView: UICollectionView!
    
    var loadScreenView: LoadScreenView!
    
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 1 // TODO: is it required?
    //    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shuffledPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsFeedCollectionViewCell", for: indexPath) as! NewsFeedCollectionViewCell
        
        
        //        print("INDEXPATH\(indexPath)")
        
        let post = shuffledPosts[indexPath.row]
        
        let friend = friends.first(where: {$0.identifier == post?.authorID})
        
        let text = post?.postText
        
        cell.configureSubviews()
        cell.configureProfileView(friend: friend!)
        cell.configurePhotos(post: post!)
        cell.configurePostText(postText: text!)
        //        print(post?.postNo)
        
        //        if indexPath.row % 2 == 0 { // ---- good for testing
        //            cell.backgroundColor = .cyan
        //            //            print(indexPath)
        //        } else {
        //            cell.backgroundColor = .clear
        //        } // ---- good for testing
        
//        collectionView.reloadItems(at: [indexPath])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! NewsFeedCollectionViewCell
        let postVC = storyboard?.instantiateViewController(withIdentifier: "PostFullSizeCollectionViewController") as! PostFullSizeCollectionViewController
        postVC.selectedPost = cell.selectedPost
        self.show(postVC, sender: nil)
        //        print(delegate.debugDescription)
    }
    
    
    override func viewDidLoad() {
        
        friends = FriendFactory().friends
        
        allPosts = friends.flatMap{$0.posts}
        
        var tempPosts = allPosts // TODO: to get rid of
        
        for _ in allPosts {
            if let index = tempPosts.indices.randomElement() {
                let post = tempPosts[index]
                shuffledPosts.append(post)
                tempPosts.remove(at: index)
            }
        }
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        let layout = newsFeedCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        super.viewDidLoad()
        
        newsFeedCollectionView.delegate = self
        newsFeedCollectionView.dataSource = self
        
        newsFeedCollectionView.register(UINib(nibName: "NewsFeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsFeedCollectionViewCell")
        
//        loadScreenView.frame = self.view.bounds
        
        loadScreenView = LoadScreenView(frame: .zero)
        loadScreenView.mainView.backgroundColor = .white
        loadScreenView.frame = self.view.bounds
        
        self.view.addSubview(loadScreenView)
        
        //-------
        
        var secondsCount = 0
        
        let timer = Timer.init(timeInterval: 1, repeats: true) { (timer) in
            secondsCount += 1
            if secondsCount == 5 {
                timer.invalidate()
                self.loadScreenView.isHidden = true
                self.navigationController?.tabBarController?.tabBar.isHidden = false
                self.navigationController?.navigationBar.isHidden = false
            }
        }
        
        RunLoop.main.add(timer, forMode: RunLoop.Mode.default)
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
        //-------
        
        //        newsFeedCollectionView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
