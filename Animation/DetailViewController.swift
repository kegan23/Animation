//
//  DetailViewController.swift
//  Animation
//
//  Created by liuxin on 16/9/21.
//  Copyright © 2016年 刘鑫. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var logo:UILabel!
    
    var menuItem:MenuItem?{
        didSet{
            
            // 用于修改详情页
            view.backgroundColor = menuItem?.color
            logo.text = menuItem?.logo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
