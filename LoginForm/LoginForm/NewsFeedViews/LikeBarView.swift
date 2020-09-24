//
//  LikeBarView.swift
//  LoginForm
//
//  Created by Andrey on 01/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class LikeBarView: UIView {
    
    @IBOutlet weak var likeButton: LikeButton!
    @IBOutlet weak var likeCounterLabel: UILabel!
    
    //-------------
    
    var animationStartDate = Date()
    var startValue = Double()
    var endValue = Double()
    var animationDuration = 1.1
    
    //-------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit() {
        let profileViewFromXib = Bundle.main.loadNibNamed("LikeBarView", owner: self, options: nil)![0] as! UIView
        profileViewFromXib.frame = self.bounds
        addSubview(profileViewFromXib)

    }
    
    @IBAction func pressLikeButton(_ sender: Any) {
        
        animationStartDate = Date()
        startValue = Double()
        endValue = Double()
        
        let count = Int(likeCounterLabel.text!) // TODO: to change to if let
        startValue = Double(count! / 2)
        
        if likeButton.filled {
            endValue = Double(count! + 1)
            //                likeCounterLabel.text = String(count! + 1)
        } else {
            let count = Int(likeCounterLabel.text!)
            endValue = Double(count! - 1)
        }
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
        
        
        
    }
    
    @objc func handleUpdate(){
        
        likeButton.isUserInteractionEnabled = false
        likeButton.superview?.superview?.superview?.isUserInteractionEnabled = false
        
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            self.likeCounterLabel.text = "\(Int((endValue)))"
            likeButton.isUserInteractionEnabled = true
            likeButton.superview?.superview?.superview?.isUserInteractionEnabled = true
        } else {
            let percentage = elapsedTime / animationDuration
            let value = startValue + percentage * (endValue - startValue)
            self.likeCounterLabel.text = "\(Int((value)))"
        }
    }
}

