//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by newbie on 2020/4/4.
//  Copyright © 2020 newbie. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    //    var restaurantNames  =  ["cafe","homei"];
    //    var restaurantImages = ["cafedeadend","homei"]
    //
    var restaurants:[Restaurant] = [
        Restaurant(name: "cafe", type: "coffee&Tea shop", location: "hong kong", image: "cafedeadend", isVisited: false, phone: "1234567890"),
        Restaurant(name: "homei", type: "cafe", location: "hong kong", image: "homei", isVisited: false, phone: "98765432"),
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // 导航栏 变透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 20
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRestuarantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RestaurantDetailViewController
                
                destinationController.restaurant = restaurants[indexPath.row]

            }
        }
        
    }
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        //弹出框
    //        let alert = UIAlertController(title: "被电击了", message: "你要干啥？", preferredStyle:.actionSheet)
    //        // 选中
    //        let checkInAction = UIAlertAction(title: "check In", style: .default){
    //            (UIAlertAction) in
    //            let cell = tableView.cellForRow(at: indexPath)
    //            cell?.accessoryType = .checkmark
    //        }
    //        // 拨打电话ß
    //        alert.addAction(checkInAction)
    //
    //        present(alert, animated: true, completion:nil)
    //
    //        self.tableView.deselectRow(at: indexPath, animated: true)
    //    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "datacell"
        //MARK: 修改cell的类名
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! RestaurantRoundCell
        cell.nameLable.text =
            restaurants[indexPath.row].name
        
        cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].image)
        cell.heartImageView.isHidden = !restaurants[indexPath.row].isVisited
        cell.typeLabel.text = restaurants[indexPath.row].type
        cell.locationLabel.text = restaurants[indexPath.row].location
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 删除按钮
        let  deleteAction = UIContextualAction(style: .destructive, title: "delete") {
            (action, sourceView,completionHandler) in
            // 删除
            self.restaurants.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        // 分享按钮
        let shareAction = UIContextualAction(style: .normal, title: "share"){
            _,_,completeHandler in
            let activityController:UIActivityViewController
            let defaultText = "just checking in at " + self.restaurants[indexPath.row].name
            if let imageToShare = UIImage(named: self.restaurants[indexPath.row].image) {
                activityController = UIActivityViewController(activityItems: [defaultText,imageToShare], applicationActivities: nil)
            }else{
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            // For ipad
            if let  popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
                
            }
            
            self.present(activityController, animated: true, completion: nil)
            
            completeHandler(true)
        }
        
        // 设计 两个按钮的背景颜色
        // 默认是灰红相间
        deleteAction.backgroundColor = UIColor(red: 255.0, green: 76.0/255.0, blue: 60, alpha: 1.0)
        deleteAction.image = UIImage(named: "delete")
        
        shareAction.image = UIImage(named: "share")
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction,shareAction])
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let checkInAction  =  UIContextualAction(style: .normal, title: "Check In"){
            (action,sourceData,completeHandler) in
            let cell = tableView.cellForRow(at: indexPath) as! RestaurantRoundCell
            self.restaurants[indexPath.row].isVisited = !self.restaurants[indexPath.row].isVisited
            // 显示/隐藏 界面元素
            cell.heartImageView.isHidden = !self.restaurants[indexPath.row].isVisited
            
            completeHandler(true)
        }
        
        // 打卡操作，和撤销操作
        
        // 修改 颜色
        // MARK: - helloworld mark
        let checkIcon = restaurants[indexPath.row].isVisited ? "arrow.uturn.left" : "checkmark"
        checkInAction.backgroundColor =
            UIColor(red: 38, green: 162, blue: 78)
        //UIColor(red: 38.0/255.0, green: 162, blue: 78, alpha: 1.0)
        checkInAction.image = UIImage(systemName: checkIcon)
        
        let swipeConfigurarion = UISwipeActionsConfiguration(actions: [checkInAction])
        return swipeConfigurarion
    }
    
    
    
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
