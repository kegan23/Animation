//
//  ViewController.swift
//  Animation
//
//  Created by liuxin on 16/9/21.
//  Copyright © 2016年 刘鑫. All rights reserved.
//

import UIKit

protocol MenuProtocol {
    func configureMenu(menu:MenuItem)
}


class ViewController: UIViewController, UIScrollViewDelegate, MenuProtocol {

    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var menuContainerView:UIView!
    
    var progress:CGFloat?
    var isFirst = true
//    var isScroll = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuContainerView.layer.anchorPoint = CGPointMake(1.0, 0.5)
        menuContainerView.layoutIfNeeded()
//        menuContainerView.setNeedsLayout()
        
//        NSLayoutConstraint.constraintsWithVisualFormat("|-view", options: .AlignAllLeading, metrics: ["view" : menuContainerView], views: <#T##[String : AnyObject]#>)
        
        var frame = menuContainerView.frame
        frame.origin.x = 0
        menuContainerView.translatesAutoresizingMaskIntoConstraints = true
        menuContainerView.frame = frame
        
        print("frame is \(menuContainerView.frame)")
        
    }
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    private var menuViewController:MenuViewController?
    private var detailViewController:DetailViewController? {
        didSet {
            if let vc = detailViewController {
                hideShowMenu(true, animate: !isFirst)
                vc.menuItem = menuItem
            }
        }
    }
    
    var menuItem:MenuItem? {
        didSet{
            if let detail = detailViewController{
                hideShowMenu(true, animate: !isFirst)
                detail.menuItem = menuItem
            }
        }
    }
    
    func hideShowMenu(show:Bool,animate:Bool){
        let menuOff = CGRectGetHeight(menuContainerView.bounds)
        scrollView.setContentOffset(show ? CGPointMake(0, menuOff):CGPointZero, animated: animate)
    }
    
    func toggleMenu(){
        let menuOff = CGRectGetHeight(menuContainerView.bounds)
        scrollView.setContentOffset(scrollView.contentOffset.y != 0 ? CGPointZero:CGPointMake(0, menuOff), animated: true)
    }
    
    func isShow() -> Bool {
        return scrollView.contentOffset.y != 0
    }
    
    @IBAction func showOrHideMenu(sender: UIButton) {
        
        if self.isShow() {
            hideShowMenu(false, animate: true)
        } else {
            hideShowMenu(true, animate: true)
        }
        
        UIView.animateWithDuration(0.5) { 
            let transform:CGAffineTransform = sender.transform;
            sender.transform = CGAffineTransformRotate(transform, CGFloat(M_PI));
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue"{
            detailViewController = segue.destinationViewController as? DetailViewController
//            detailViewController.delegate = self
        }
        else if segue.identifier == "MenuSegue"{
            menuViewController = segue.destinationViewController as? MenuViewController
            menuViewController?.delegate = self
        }
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let multipier = 1/menuContainerView.bounds.height
//        print("frame is \(menuContainerView.frame.size.height)")
//        print("bounds is \(menuContainerView.bounds.height)")
        progress = 1 - ((scrollView.contentOffset.y) * multipier)
        menuContainerView.layer.transform = menuTransformForPercent(progress!)
        menuContainerView.alpha = 1.0 - progress!
        scrollView.pagingEnabled = scrollView.contentOffset.y < (scrollView.contentSize.height - CGRectGetHeight(scrollView.frame))
        isFirst = false
    }
    
    func menuTransformForPercent(percent: CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000   //1 / [camera distance]
        let remainingPercent = percent
        let angle = remainingPercent * CGFloat(-M_PI_2)
//        print("angle is \(angle)")
        let rotationTransform = CATransform3DRotate(identity, angle,
                                                    1.0, 0.0, 0.0)
        let translationTransform =
            CATransform3DMakeTranslation(0, -menuContainerView.bounds.size.height/2*(1-cos(angle)), 0)
        
        
//        let transform3d = CATransform3DMakeTranslation(0, -menuContainerView.frame.size.height/2*sinf(angle), -menuContainerView.frame.size.height/2*(1-cosf(angle)));
        return CATransform3DConcat(rotationTransform,
                                   translationTransform)
    }
    
    func configureMenu(menu: MenuItem) {
        self.menuItem = menu
    }
}

