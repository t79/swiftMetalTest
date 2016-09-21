//
//  ViewController.swift
//  SwiftMetalTest
//
//  Created by Terje Urnes on 21.09.2016.
//  Followed tutorial by Ray Wenderlich, see README.md
//

import UIKit
import Metal

class ViewController: UIViewController {
    
    var device: MTLDevice! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        device = MTLCreateSystemDefaultDevice()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

