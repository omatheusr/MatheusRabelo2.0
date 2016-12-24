//
//  TransitionSwipeUpManager.swift
//  MatheusRabelo 2.0
//
//  Created by Matheus Oliveira Rabelo on 12/23/16.
//  Copyright © 2016 Matheus. All rights reserved.
//

import UIKit

class TransitionSwipeUpManager: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    private var interactive = false
    private var presenting = false
    
    private var enterPanGesture : UIPanGestureRecognizer?
    private var exitPanGesture  : UIPanGestureRecognizer?
    
    weak var sourceViewController : UIViewController? {
        didSet{
            guard let sourceViewController = self.sourceViewController else {
                self.enterPanGesture = nil
                return
            }
            let enterPanGesture = UIPanGestureRecognizer()
            enterPanGesture.addTarget(self, action: #selector(handleOnstagePan(pan:)))
            
            sourceViewController.view.addGestureRecognizer(enterPanGesture)
            self.enterPanGesture = enterPanGesture
        }
    }
    weak var destinationViewController: UIViewController? {
        didSet {
            guard let destinationViewController = self.destinationViewController else {
                self.exitPanGesture = nil
                return
            }
            
            let exitPanGesture = UIPanGestureRecognizer()
            exitPanGesture.addTarget(self, action: #selector(handleOffstagePan(pan:)))
            
            destinationViewController.view.addGestureRecognizer(exitPanGesture)
            self.exitPanGesture = exitPanGesture
        }
    }
    var segueToDestination : String?
    var segueToUnwind      : String?
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let container              = transitionContext.containerView
        let duration               = self.transitionDuration(using: transitionContext)
        let fromView    : UIView!  = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView      : UIView!  = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        let offScreenDown   = CGAffineTransform(translationX: 0, y: container.frame.height)
        let offScreenUp     = CGAffineTransform(translationX: 0, y: -container.frame.height/2)
        let offScreenSize   = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        
        container.addSubview(fromView)
        container.addSubview(toView)
        
        if self.presenting {
            toView.transform = offScreenDown
            container.bringSubview(toFront: toView)
        }else{
            toView.layer.opacity = 0
            toView.transform = offScreenSize.concatenating(offScreenUp)
            container.bringSubview(toFront: fromView)
        }
        

        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: {
            
            if self.presenting {
                fromView.transform = offScreenSize.concatenating(offScreenUp)
                fromView.layer.opacity = 0
                toView.transform = CGAffineTransform.identity
            }else{
                fromView.transform = offScreenDown
                toView.transform = CGAffineTransform.identity
                toView.layer.opacity = 1
            }
            
        }) { (completed) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    
    // MARK: - UIViewControllerInteractiveTransitioning
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
    func handleOnstagePan(pan: UIPanGestureRecognizer){
        let translation = pan.translation(in: pan.view)
        let velocity    = pan.velocity(in: pan.view)
        
        let d = translation.y / (pan.view?.bounds.height ?? 0) * -0.2
        
//        print("d = \(d) | translation = \(translation) | velocity = \(velocity)")
        
        switch pan.state {
        case UIGestureRecognizerState.began:
            self.interactive = true
            
            if let segueToDestination = self.segueToDestination {
                self.sourceViewController?.performSegue(withIdentifier: segueToDestination, sender: nil)
            }
        case UIGestureRecognizerState.changed:
            self.update(d)
            break
            
        default: // .Ended, .Cancelled, .Failed ...
            self.interactive = false
            if(d > 0.10 || velocity.y < -1500){
                self.completionSpeed = 1
                self.finish()
            } else {
                self.completionSpeed = 0.2
                self.cancel()
            }
        }
        
    }
    func handleOffstagePan(pan: UIPanGestureRecognizer){
        let translation = pan.translation(in: pan.view)
        let velocity    = pan.velocity(in: pan.view)
        
        let d = translation.y / (pan.view?.bounds.height ?? 0) * 0.2
        
//        print("d = \(d) | translation = \(translation) | velocity = \(velocity)")
        
        switch pan.state {
        case UIGestureRecognizerState.began:
            self.interactive = true
            if let segueToUnwind = self.segueToUnwind {
                self.destinationViewController?.performSegue(withIdentifier: segueToUnwind, sender: nil)
            }
        case UIGestureRecognizerState.changed:
            self.update(d)
            break
            
        default: // .Ended, .Cancelled, .Failed ...
            self.interactive = false
            if(d > 0.09 || velocity.y > 1500){
                self.completionSpeed = 1
                self.finish()
            } else {
                self.completionSpeed = 0.2
                self.cancel()
            }
        }
        
    }
}
