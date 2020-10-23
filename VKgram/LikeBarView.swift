//
//  LikeBarView.swift
//  LoginForm
//
//  Created by Andrey on 01/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class LikeBarView: UIView {
    
    var likeButton: LikeButton = {
        let button = LikeButton()
        button.strokeColor = .white
        button.tintColor = .systemPink
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var likeCounterLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(20) // TODO: to add to constants
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //-------------
    
    var animationStartDate = Date()
    var startValue = Double()
    var endValue = Double()
    var animationDuration = 1.1
    
    //-------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(likeButton)
        addSubview(likeCounterLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            likeButton.topAnchor.constraint(equalTo: topAnchor),
            likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),  // TODO: to add to constants
            likeButton.widthAnchor.constraint(equalTo: likeButton.heightAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 40), // TODO: to add to constants
            
            likeCounterLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: 8),
            likeCounterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            likeCounterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            likeCounterLabel.heightAnchor.constraint(equalToConstant: 40), // TODO: to add to constants
            
        ])
        
    }
    
    @objc func likeButtonPressed(_ sender: Any) {
        
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

