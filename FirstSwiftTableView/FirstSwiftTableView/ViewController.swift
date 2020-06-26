//
//  ViewController.swift
//  FirstSwiftTableView
//
//  Created by newbie on 2020/4/4.
//  Copyright © 2020 newbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdntifier = "datacell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdntifier, for: indexPath)
        cell.textLabel?.text = restaurantNames[indexPath.row]
        cell.imageView?.image = UIImage(named: "restaurant")
        return cell
    }
//    var restaurantNames = ["cafe":"restaurant","home":"","hello":"restaurant"]
    
    var restaurantNames = [ "cafe","home"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

