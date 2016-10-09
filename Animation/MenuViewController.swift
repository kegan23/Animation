//
//  MenuViewController.swift
//  Animation
//
//  Created by liuxin on 16/9/21.
//  Copyright © 2016年 刘鑫. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var detailVC: DetailViewController!                     // 详情页
    var delegate: MenuProtocol?                             // 代理
    @IBOutlet weak var collectionView: UICollectionView!    // collection
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate?.configureMenu(MenuItem.shareItems[0])
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.customInterface()

    }
    
    // MARK: - Init
    func customInterface() {
        
        let width = self.collectionView.frame.size.width / CGFloat(MenuItem.shareItems.count)
        let height = self.collectionView.frame.size.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.itemSize = CGSizeMake(width, height)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - collectionView Delegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuItem.shareItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MenuCell
        cell.configureCell(MenuItem.shareItems[indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        (parentViewController as! ViewController).menuItem = MenuItem.shareItems[indexPath.row]
    }
    
    

}
