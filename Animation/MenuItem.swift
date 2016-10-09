//
//  MenuItem.swift
//  Animation
//
//  Created by liuxin on 16/9/21.
//  Copyright © 2016年 刘鑫. All rights reserved.
//

import UIKit

let menuColors = [
    UIColor(red: 249/255, green: 84/255,  blue: 7/255,   alpha: 1.0),
    UIColor(red: 249/255, green: 194/255, blue: 7/255,   alpha: 1.0),
    UIColor(red: 14/255,  green: 88/255,  blue: 149/255, alpha: 1.0),
    UIColor(red: 15/255,  green: 193/255, blue: 231/255, alpha: 1.0)
]

class MenuItem {

    let logo: String
    let color: UIColor
    
    init(logo: String, color: UIColor) {
        self.logo = logo
        self.color = color
    }
    
    static var shareItems:[MenuItem] {
        var items = [MenuItem]()
        items.append(MenuItem(logo: "☎︎", color: menuColors[0]))
        items.append(MenuItem(logo: "♻︎", color: menuColors[1]))
        items.append(MenuItem(logo: "♞", color: menuColors[2]))
        items.append(MenuItem(logo: "✾", color: menuColors[3]))
        
        return items
    }
}
