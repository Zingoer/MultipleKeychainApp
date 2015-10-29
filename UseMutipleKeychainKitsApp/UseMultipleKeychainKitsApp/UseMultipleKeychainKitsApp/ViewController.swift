//
//  ViewController.swift
//  UseMultipleKeychainKitsApp
//
//  Created by Xiaoxi Pang on 10/29/15.
//  Copyright © 2015 Zingoer. All rights reserved.
//

import UIKit
import MultipleKeychainKits

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let keyManager = KeyManager()
        keyManager.generateKey()
        print("\(keyManager.key)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

