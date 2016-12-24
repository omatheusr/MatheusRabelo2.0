//
//  AboutMeViewController.swift
//  MatheusRabelo 2.0
//
//  Created by Matheus Oliveira Rabelo on 12/24/16.
//  Copyright © 2016 Matheus. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController {

    @IBOutlet weak var viewPresentation: UIView!
    @IBOutlet weak var stackHistory: UIStackView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = 10
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.lblTitle.layer.opacity = 0
        self.lblSubtitle.layer.opacity = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.7, delay: 0.4, options: .curveEaseIn, animations: {
            self.lblTitle.layer.opacity = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.8, options: .curveEaseIn, animations: {
            self.lblSubtitle.layer.opacity = 1
        }, completion: nil)
        
        
        UIView.animate(withDuration: 0.5, delay: 1.2, options: UIViewAnimationOptions.curveEaseIn, animations: { 
            
//            let nConstraintTop = NSLayoutConstraint(item: self.topLayoutGuide, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem:self.viewPresentation, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 50)
//            let nConstraintLeading = NSLayoutConstraint(item: self.viewPresentation.superview!, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.viewPresentation, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 25)
//            
//            self.viewPresentation.removeConstraints(self.viewPresentation.constraints)
//            self.viewPresentation.addConstraints([nConstraintTop, nConstraintLeading])
//            
//            self.view.layoutSubviews()
        }, completion: nil)
    }
}
