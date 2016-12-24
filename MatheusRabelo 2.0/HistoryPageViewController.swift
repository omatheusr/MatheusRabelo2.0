//
//  HistoryPageViewController.swift
//  MatheusRabelo 2.0
//
//  Created by Matheus Oliveira Rabelo on 12/23/16.
//  Copyright © 2016 Matheus. All rights reserved.
//

import UIKit

class HistoryPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    
    var pages : [HistoryViewController] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.red
        self.view.layer.masksToBounds = true
        self.view.layer.cornerRadius = 10
        
        self.loadPages()
        
        self.delegate = self
        self.dataSource = self
        
        self.setViewControllers([self.pages[0]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let page = viewController as? HistoryViewController,
               page.index + 1 < self.pages.count
        {
            return self.pages[page.index + 1]
        }else{
            return nil
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let page = viewController as? HistoryViewController {
            if page.index == 0 { return nil }
            return self.pages[page.index - 1]
        } else {
            return nil
        }
    }
    
    //
    private func loadPages(){
//        self.pages.append(HistoryViewController.Pages.AboutMe.getViewController())
    }
}
