//
//  PresentationViewController.swift
//  MatheusRabelo 2.0
//
//  Created by Matheus Oliveira Rabelo on 12/23/16.
//  Copyright © 2016 Matheus. All rights reserved.
//

import UIKit

class PresentationViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgCloud1: UIImageView!
    @IBOutlet weak var imgCloud2: UIImageView!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSurname: UILabel!
    @IBOutlet weak var viewBubble: AnimatedDialogUIView!
    @IBOutlet weak var viewPhoto: AnimatedCircleExpandingUIView!
    
    private var loaded = false
    
    let transitionManager = TransitionSwipeUpManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitionManager.sourceViewController = self
        self.transitionManager.segueToDestination = "segueToAboutMe"
        self.transitionManager.segueToUnwind = "segueToUnwind"
        
        self.view.layer.masksToBounds = true
        
        UIView.parallax(minXY: -20, maxXY: 20, views: self.imgBackground)
        UIView.parallax(minXY: 10, maxXY: -10, views: self.imgCloud1, self.imgCloud2)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(photoTap(gesture:)))
        self.imgPhoto.isUserInteractionEnabled = true
        self.imgPhoto.addGestureRecognizer(tap)
        self.viewPhoto.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !self.loaded {
            self.view.layer.cornerRadius = 10
            self.imgBackground.isHidden = true
            self.viewBubble.prepareToAnimate()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !self.loaded {
            self.loaded = true
            UIView.animate(withDuration: 1.2, delay: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.imgBackground.isHidden = false
            }, completion: nil)
            
            self.viewBubble.animate(delay: 10)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let to : AboutMeViewController! = segue.destination as? AboutMeViewController
        to.transitioningDelegate = self.transitionManager
        self.transitionManager.destinationViewController = to
    }
    
    @IBAction func unwindSegueFromHistory(segue: UIStoryboardSegue) {
        
    }
    
    func photoTap(gesture : UITapGestureRecognizer) {
        let touchPoint = gesture.location(ofTouch: 0, in: self.viewPhoto)
        self.viewPhoto.animate(startingAt: touchPoint)
    }
}
