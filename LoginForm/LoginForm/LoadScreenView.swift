//
//  LoadScreenView.swift
//  LoginForm
//
//  Created by Andrey on 04/09/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class LoadScreenView: UIView {
    
    @IBOutlet weak var spinnerView: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    
    let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("LoadScreenView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
    }
    
    override func didMoveToSuperview() {
        setUpLayer()
        layer.addSublayer(shapeLayer)
    }
    
    func setUpLayer() {
        
        shapeLayer.frame = self.bounds
        self.layer.addSublayer(shapeLayer)
        
        shapeLayer.strokeStart = 0.0
        shapeLayer.strokeEnd = 1.0
        shapeLayer.fillColor = UIColor.gray.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 3.0
        
        let rect = self.bounds
        shapeLayer.backgroundColor = UIColor.clear.cgColor
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 162.11, y: 119.94))
        path.addLine(to: CGPoint(x: 43.82, y: 119.94))
        path.addCurve(to: CGPoint(x: 0, y: 73.15), controlPoint1: CGPoint(x: 19.66, y: 119.94), controlPoint2: CGPoint(x: 0, y: 98.95))
        path.addCurve(to: CGPoint(x: 43.82, y: 26.36), controlPoint1: CGPoint(x: 0, y: 47.36), controlPoint2: CGPoint(x: 19.66, y: 26.36))
        path.addCurve(to: CGPoint(x: 55.56, y: 28.11), controlPoint1: CGPoint(x: 47.76, y: 26.36), controlPoint2: CGPoint(x: 51.7, y: 26.95))
        path.addCurve(to: CGPoint(x: 95.84, y: -0.33), controlPoint1: CGPoint(x: 62.4, y: 10.97), controlPoint2: CGPoint(x: 78.22, y: -0.33))
        path.addCurve(to: CGPoint(x: 128.64, y: 15.49), controlPoint1: CGPoint(x: 108.49, y: -0.33), controlPoint2: CGPoint(x: 120.3, y: 5.4))
        path.addCurve(to: CGPoint(x: 140.89, y: 12.83), controlPoint1: CGPoint(x: 132.51, y: 13.74), controlPoint2: CGPoint(x: 136.7, y: 12.83))
        path.addCurve(to: CGPoint(x: 172.39, y: 46.46), controlPoint1: CGPoint(x: 158.26, y: 12.83), controlPoint2: CGPoint(x: 172.39, y: 27.92))
        path.addCurve(to: CGPoint(x: 171.52, y: 54.22), controlPoint1: CGPoint(x: 172.39, y: 49.06), controlPoint2: CGPoint(x: 172.09, y: 51.66))
        path.addCurve(to: CGPoint(x: 193.61, y: 86.31), controlPoint1: CGPoint(x: 184.51, y: 58.55), controlPoint2: CGPoint(x: 193.61, y: 71.5))
        path.addCurve(to: CGPoint(x: 162.11, y: 119.94), controlPoint1: CGPoint(x: 193.61, y: 104.85), controlPoint2: CGPoint(x: 179.48, y: 119.94))
        path.close()
        
        path.fit(into: rect).moveCenter(to: rect.center).fill()
        path.scale(x: 0.5, y: 0.5)
        shapeLayer.path = path.cgPath
        
        let strokeStartAnim = CAKeyframeAnimation(keyPath: "strokeStart")
        strokeStartAnim.values = [1, 0]
        strokeStartAnim.keyTimes = [0,1]
        strokeStartAnim.duration = 2.0
        
        
        let strokeEndAnim = CAKeyframeAnimation(keyPath: "strokeEnd")
        strokeEndAnim.values = [1, 0]
        strokeEndAnim.keyTimes = [0,1]
        strokeEndAnim.duration = 2
        strokeEndAnim.beginTime = 0.4
        
        let groupAnim = CAAnimationGroup()
        groupAnim.animations = [strokeStartAnim, strokeEndAnim]
        groupAnim.fillMode = CAMediaTimingFillMode.forwards
        groupAnim.duration = 2.0
        groupAnim.repeatCount = .infinity
        shapeLayer.add(groupAnim, forKey: "AnimateSnake")
        
    }
    
}

