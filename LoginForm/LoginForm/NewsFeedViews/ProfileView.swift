//
//  ProfileView.swift
//  LoginForm
//
//  Created by Andrey on 29/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var friendImage: RoundImageView!
    @IBOutlet weak var friendName: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func commonInit() {
        let profileViewFromXib = Bundle.main.loadNibNamed("ProfileView", owner: self, options: nil)![0] as! UIView
        profileViewFromXib.frame = self.bounds
        addSubview(profileViewFromXib)
    }
    
}
