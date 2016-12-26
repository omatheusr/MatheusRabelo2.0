//
//  AboutMeViewController.swift
//  MatheusRabelo 2.0
//
//  Created by Matheus Oliveira Rabelo on 12/24/16.
//  Copyright © 2016 Matheus. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController {

    @IBOutlet weak var constraintViewPresentationBottom: NSLayoutConstraint!
    @IBOutlet weak var viewPresentation: UIView!
    @IBOutlet weak var stackHistory: UIStackView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    
    private var loaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = 10
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if self.loaded { return }
        
        for i in 1...6{
            guard let lbl = self.view.viewWithTag(i) as? UILabel else { continue }
            lbl.layer.opacity = 0
            lbl.transform = lbl.transform.translatedBy(x: 0, y: 10)
        }
        
        self.lblTitle.layer.opacity = 0
        self.lblSubtitle.layer.opacity = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.loaded { return }
        self.loaded = true
        
        UIView.animate(withDuration: 0.7, delay: 0.4, options: .curveEaseIn, animations: {
            self.lblTitle.layer.opacity = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.8, options: .curveEaseIn, animations: {
            self.lblSubtitle.layer.opacity = 1
        }, completion: {
            completed in
            
            self.constraintViewPresentationBottom.constant = self.view.frame.size.height - self.viewPresentation.frame.size.height * 2
            UIView.animate(withDuration: 0.7, delay: 1, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.view.layoutSubviews()
            }, completion: {
                completed in
                
                self.stackHistory.isHidden = false
                for i in 1...6{
                    guard let lbl = self.view.viewWithTag(i) as? UILabel else { continue }
                    
                    UIView.animate(withDuration: 0.7, delay: TimeInterval(Double(i)*0.5), options: UIViewAnimationOptions.curveEaseIn, animations: {
                        lbl.layer.opacity = 1
                        lbl.transform = CGAffineTransform.identity
                    }, completion: nil)
                }

            })
            
        })
        
        
    }
}
