//
//  MenuCell.swift
//  Animation
//
//  Created by liuxin on 16/9/21.
//  Copyright © 2016年 刘鑫. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    @IBOutlet weak var logo: UILabel!
    
    func configureCell(item:MenuItem) {
        
        logo.text = item.logo
        logo.textColor = UIColor.whiteColor()
        logo.font = UIFont.boldSystemFontOfSize(30)
        logo.textAlignment = .Center
        logo.backgroundColor = UIColor.clearColor()
        
        self.backgroundColor = item.color
        
    }
    
}
