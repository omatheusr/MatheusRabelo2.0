//
//  AnimatedCircleExpandingUIView.swift
//  MatheusRabelo 2.0
//
//  Created by Matheus Oliveira Rabelo on 12/24/16.
//  Copyright © 2016 Matheus. All rights reserved.
//

import UIKit

class AnimatedCircleExpandingUIView: UIView, CAAnimationDelegate {
    
    @IBInspectable var circleColor : UIColor = UIColor.black
    @IBInspectable var animationDuration : CFTimeInterval = 0.5
    
    private var currentAnimationLayer : CAShapeLayer?
    
    func animate(startingAt: CGPoint){
        
        let viewP0 = self.bounds.origin
        let viewP1 = CGPoint(x: self.bounds.width, y: self.bounds.origin.y)
        let viewP2 = CGPoint(x: self.bounds.width, y: self.bounds.height)
        let viewP3 = CGPoint(x: self.bounds.origin.x, y: self.bounds.height)
        
        let d0 = abs(hypot(startingAt.x - viewP0.x, startingAt.y - viewP0.y))
        let d1 = abs(hypot(startingAt.x - viewP1.x, startingAt.y - viewP1.y))
        let d2 = abs(hypot(startingAt.x - viewP2.x, startingAt.y - viewP2.y))
        let d3 = abs(hypot(startingAt.x - viewP3.x, startingAt.y - viewP3.y))
        
        let r = max(d0, d1, d2, d3)
        
        
        let rectBig   = CGRect(x: startingAt.x-r, y: startingAt.y-r, width: r*2, height: r*2)
        let rectSmall = CGRect(x: startingAt.x-1, y: startingAt.y-1, width: 2, height: 2)
        
        
        let smallCircle = UIBezierPath(ovalIn: rectSmall)
        let bigCircle = UIBezierPath(ovalIn: rectBig)
        
        
        let nLayer = CAShapeLayer()
        nLayer.path = smallCircle.cgPath
        nLayer.fillColor = self.circleColor.cgColor
        
        self.layer.addSublayer(nLayer)
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.delegate = self
        animation.fromValue = smallCircle.cgPath
        animation.toValue = bigCircle.cgPath
        animation.duration = self.animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        animation.isRemovedOnCompletion = true
        
        nLayer.add(animation, forKey: animation.keyPath)
        nLayer.path = bigCircle.cgPath
        self.currentAnimationLayer = nLayer
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.currentAnimationLayer?.removeFromSuperlayer()
    }
}
