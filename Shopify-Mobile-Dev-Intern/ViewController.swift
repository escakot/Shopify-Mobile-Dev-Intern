//
//  ViewController.swift
//  Shopify-Mobile-Dev-Intern
//
//  Created by Errol Cheong on 2017-09-05.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var networkManager: NetworkManager!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    networkManager = NetworkManager()
    
    
    networkManager.getShopifyData { (data:[String : AnyObject]?) in
      guard let data = data else { return }
      let orders = data["orders"] as! [[String:AnyObject]]
      
      var moneySpent = 0.0
      for order in orders
      {
        guard order["customer"] != nil else { continue }
        let customerFirstName = (order["customer"] as! [String:AnyObject])["first_name"] as! String
        let customerLastName = (order["customer"] as! [String:AnyObject])["last_name"] as! String
        let customerFullName = String(format:"%@ %@", customerFirstName, customerLastName)
        
        if customerFullName == "Napoleon Batz"
        {
          moneySpent = moneySpent + Double(order["total_price"] as! String)!
        }
        
      }
//      print(orders)
    }
    
  }
  
}
