//
//  AnimatedDialogUIView.swift
//  MatheusRabelo 2.0
//
//  Created by Matheus Oliveira Rabelo on 12/24/16.
//  Copyright © 2016 Matheus. All rights reserved.
//

import UIKit

@IBDesignable
class AnimatedDialogUIView: UIView {

    override func draw(_ rect: CGRect) {
        let pathBack = UIBezierPath(roundedRect: rect, cornerRadius: 4)
        
        let pathArrow = UIBezierPath()
        pathArrow.move(to: CGPoint(x: 0, y: self.bounds.height-4))
        pathArrow.addLine(to: CGPoint(x: 0, y: self.bounds.height + 24))
        pathArrow.addLine(to: CGPoint(x: 20, y: self.bounds.height-4))
        pathArrow.addLine(to: CGPoint(x: 0, y: self.bounds.height-4))
        
        let paths = CGMutablePath()
        paths.addPath(pathBack.cgPath)
        paths.addPath(pathArrow.cgPath)
        
        let layerBack = CAShapeLayer()
        layerBack.path = paths
        layerBack.fillColor = UIColor.white.cgColor
        
        layerBack.shadowColor = UIColor.black.cgColor
        layerBack.shadowRadius = 2.0
        layerBack.shadowOpacity = 0.2
        layerBack.shadowOffset = CGSize(width: 0, height: 4)

        
        self.layer.insertSublayer(layerBack, at: 0)
    }
    
    func prepareToAnimate(){
        self.layer.opacity = 0
        self.transform = self.transform.translatedBy(x: 0, y: -10)
    }
    func animate(delay: TimeInterval){
        UIView.animate(withDuration: 1, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.layer.opacity = 1
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }

}
