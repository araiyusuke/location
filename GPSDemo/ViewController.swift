//
//  ViewController.swift
//  GPSDemo
//
//  Created by yusukearai on 2016/09/15.
//  Copyright © 2016年 yusuke arai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var location = Location()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location.start({ location in
            print(location.getLat())
            print(location.getLng())
        })
        
        location.finish()
        
    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

