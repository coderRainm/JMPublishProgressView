//
//  ViewController.swift
//  JMPublishProgressView
//
//  Created by CXY on 2018/3/12.
//  Copyright © 2018年 CXY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var progerss: JMPublishProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progerss.startAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changed(_ sender: UISlider) {
        progerss.setProgress(CGFloat(sender.value), animated: true)
    }
    
}

