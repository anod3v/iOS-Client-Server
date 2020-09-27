//
//  ImageScrollViewController.swift
//  LoginForm
//
//  Created by Andrey on 06/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class ImageScrollViewController: UIViewController {
    
    var selectedFriend = Friend()
    
    var selectedImageURL: URL?
    
    var imageURLs = [URL?]()
    
    var index: Int?
    
    var moveDirection = CGFloat()
    
    @IBOutlet weak var imageView: UIImageView!
    
    //------
    
    let layer = CALayer()
    
    //------
    
    @objc func swipeMade(_ sender: UISwipeGestureRecognizer) {
        
        if sender.direction == .right {
            //            print("left swipe made")
            index! -= 1
            moveDirection = self.view.bounds.width
            if imageURLs.indices.contains(index!) {
                animateSwipe()
            }
        }
        if sender.direction == .left {
            //            print("right swipe made")
            index! += 1
            moveDirection = (0 - self.view.bounds.width)
            if imageURLs.indices.contains(index!) {
                animateSwipe()
            }
            
        }
    }
    
    func animateSwipe() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.imageView.frame.origin.x = self.imageView.frame.origin.x + self.moveDirection
        },completion: { _ in
            
            UIView.transition(with: self.imageView,
                              duration: 0.75,
                              options: .transitionCrossDissolve,
                              animations: { self.imageView.image = UIImage(contentsOfFile: self.imageURLs[self.index!]!.path) },
                              completion: nil)
        })
    }
    
    //    func animateImages(newImage: UIImage) {
    //        let animationsGroup = CAAnimationGroup()
    //        animationsGroup.duration = 0.5
    //        animationsGroup.fillMode = CAMediaTimingFillMode.backwards
    //
    //        let translation = CABasicAnimation(keyPath: "position.x")
    //        translation.toValue = 100
    //        let alpha = CABasicAnimation(keyPath: "opacity")
    //        alpha.toValue = 0
    //
    //        animationsGroup.animations = [translation, alpha]
    //
    //        layer.add(animationsGroup, forKey: nil)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        guard let path = imageURLs.first(where: { $0 == selectedImageURL })??.path
            else {
                return imageView.image = UIImage(named: "not found")
        }
        index = imageURLs.firstIndex(of: selectedImageURL!)
        imageView.image = UIImage(contentsOfFile: path)
        
        
        var leftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeMade(_:)))
        leftRecognizer.direction = .left
        var rightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeMade(_:)))
        rightRecognizer.direction = .right
        self.view.addGestureRecognizer(leftRecognizer)
        self.view.addGestureRecognizer(rightRecognizer)
    }
    
}
