//
//  ViewController.swift
//  PageViewController
//
//  Created by XieLibin on 16/7/6.
//  Copyright © 2016年 Menglingfeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pageViewController : PageViewController!
    var vcList = [UIViewController]()
    var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for index in 0...3 {
            let viewController = UIViewController()
            let random = Float(arc4random() % 256)
            viewController.view.backgroundColor = UIColor.init(colorLiteralRed: random / 256, green: random / 256, blue: random / 256, alpha: 1)
            
            viewController.title = "title\(index)"
            vcList.append(viewController)
        }
        
        
        pageViewController = PageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: [UIPageViewControllerOptionInterPageSpacingKey : 0.0])
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        let first = vcList[index]
        pageViewController.setViewControllers([first], direction: .Forward, animated: false, completion: nil)
        
        view.addSubview(pageViewController.view)
        self.addChildViewController(pageViewController)
        pageViewController.didMoveToParentViewController(self)
        
        let v = NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view" : pageViewController.view])
        view.addConstraints(v)
        
        let h = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view" : pageViewController.view])
        view.addConstraints(h)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func nextVc() -> UIViewController? {
        index += 1
        guard -1 < index && index < vcList.count - 1 else{
          return nil
        }
        
        return vcList[index]
    }
    
    
    func previousVc() -> UIViewController? {
        index -= 1
        guard -1 < index && index < vcList.count - 1 else{
            return nil
        }
        
        return vcList[index]
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
}



extension ViewController : UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        return previousVc()
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        return nextVc()
    }
    
    
    
}

