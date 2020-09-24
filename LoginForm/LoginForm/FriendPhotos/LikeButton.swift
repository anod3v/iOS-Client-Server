//
//  LikeButton.swift
//  LoginForm
//
//  Created by Andrey on 17/08/2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit

class LikeButton: UIButton {
    
var filled: Bool = false {
        didSet {
            setNeedsDisplay()
            print("filled has changed")
        }
    }
    
//    var hue: CGFloat {
//      didSet {
//        setNeedsDisplay()
//      }
//    }
var strokeWidth: CGFloat = 2.0 // TODO: to adjust
    
var strokeColor: UIColor?
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else {
          return
        } // ray
        
        let bezierPath = UIBezierPath(heartIn: self.bounds)
        
        if self.strokeColor != nil {
            self.strokeColor!.setStroke()
        } else {
            self.tintColor.setStroke()
        }
        
        
        bezierPath.lineWidth = self.strokeWidth
        bezierPath.stroke()
        
//        let outerColor = UIColor(
//        hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
//        if state != .highlighted {
          context.saveGState()
//          context.setFillColor(outerColor.cgColor)
//          context.setShadow(offset: CGSize(width: 0, height: 2),
//            blur: 3.0, color: shadowColor.cgColor)
            context.addPath(bezierPath.cgPath)
//          context.fillPath()
          context.restoreGState()
//        }
        
        if self.filled {
            self.tintColor.setFill()
            bezierPath.fill()
        }
        
//        guard let context = UIGraphicsGetCurrentContext() else {
//          return
//        }

//        let color = UIColor(hue: hue,
//                            saturation: 1.0,
//                            brightness: 1.0,
//          alpha: 1.0)
//
//        color.setStroke()

//        context.setFillColor(color.cgColor)
//        context.fill(bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
//      self.hue = 0.5
      
      super.init(coder: aDecoder)
      
      self.isOpaque = false
      self.backgroundColor = .clear
    self.addTarget(self, action:#selector(buttonIsTapped), for: .touchUpInside)
    }
    
    
//        print("tap is working")
    

    @objc func buttonIsTapped() {
        print("button is tapped")
//        hue += 0.5
        if self.filled {
            self.filled = false
        } else {
            self.filled = true
        }
    }
    
}

extension UIBezierPath {
    convenience init(heartIn rect: CGRect) {
        self.init()
        
        //Calculate Radius of Arcs using Pythagoras
        let sideOne = rect.width * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
        
        //Left Hand Curve
        self.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        
        //Top Centre Dip
        self.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.2))
        
        //Right Hand Curve
        self.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        
        //Right Bottom Line
        self.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))
        
        //Left Bottom Line
        self.close()
    }
}

extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}
