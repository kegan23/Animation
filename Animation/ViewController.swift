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
        
//        menuContainerView.layer.anchorPoint = CGPointMake(1.0, 0.5)
//        menuContainerView.layoutIfNeeded()

//        var frame = menuContainerView.frame
//        frame.origin.x = 0
//        menuContainerView.translatesAutoresizingMaskIntoConstraints = true
//        menuContainerView.frame = frame
    }
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    //MARK: - Init
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
    
    // MARK: - Action
    /**
     *  @brief 显示／隐藏菜单按钮
     *
     *  @param show     是否显示
     *  @param animate  是否动画
     */
    func hideShowMenu(show:Bool,animate:Bool){
        let menuOff = CGRectGetHeight(menuContainerView.bounds)
        scrollView.setContentOffset(show ? CGPointMake(0, menuOff):CGPointZero, animated: animate)
    }
    
    /**
     *  @brief 自动弹回底部tabbar
     */
    func toggleMenu(){
        let menuOff = CGRectGetHeight(menuContainerView.bounds)
        scrollView.setContentOffset(scrollView.contentOffset.y != 0 ? CGPointZero:CGPointMake(0, menuOff), animated: true)
    }
    
    /**
     *  @brief 是否显示底部tabbar
     *
     *  @return Bool值
     */
    func isShow() -> Bool {
        return scrollView.contentOffset.y != 0
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
    
    /**
     *  @brief 计算滚动距离百分比
     */
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let multipier = 1/menuContainerView.bounds.height
        progress = 1 - ((scrollView.contentOffset.y) * multipier)
        menuContainerView.layer.transform = menuTransformForPercent(progress!)
        scrollView.pagingEnabled = scrollView.contentOffset.y < (scrollView.contentSize.height - CGRectGetHeight(scrollView.frame))
        isFirst = false
    }
    
    /**
     *  @brief 根据滚动距离制作动画
     *
     *  @param percent 移动距离百分比
     *
     *  @return 旋转动画
     */
    func menuTransformForPercent(percent: CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000   //1 / [camera distance]
        let remainingPercent = percent
        let angle = remainingPercent * CGFloat(-M_PI_2)
        
        let rotationTransform = CATransform3DRotate(identity, angle,
                                                    1.0, 0.0, 0.0)
        let translationTransform =
            CATransform3DMakeTranslation(0, -menuContainerView.bounds.size.height/2*(1-cos(angle)), 0)

        return CATransform3DConcat(rotationTransform,
                                   translationTransform)
    }
    
    func configureMenu(menu: MenuItem) {
        self.menuItem = menu
    }
    
    // MARK: - 按钮点击
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
}

