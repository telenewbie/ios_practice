//
//  ViewController.swift
//  FirstSwiftApp
//
//  Created by newbie on 2020/4/3.
//  Copyright © 2020 newbie. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    var lockVal = NSObject()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("hello")
        DispatchQueue.global().async {
            objc_sync_enter(ViewController.self)
            //....
            objc_sync_exit(ViewController.self)
        }
    }

    
    @IBAction func showMessage(sender: UIButton){

        let selectedButton = sender
        if let wordToLookup = selectedButton.titleLabel?.text{
            let alertController = UIAlertController(title: "ok", message: wordToLookup, preferredStyle: UIAlertController.Style.alert);
            
            alertController.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
        }
    }
   
    
    //HelloSwift-Bridging-Header.h
    
}

