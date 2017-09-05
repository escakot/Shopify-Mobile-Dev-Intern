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
      var totalBronzeBags = 0
      for order in orders
      {
        //Check all items purchased
        let itemsPurchased = order["line_items"] as! [[String:AnyObject]]
        
        for item in itemsPurchased
        {
          if item["title"] as! String == "Awesome Bronze Bag"
          {
            totalBronzeBags = totalBronzeBags + (item["quantity"] as! Int)
          }
        }
        
        //Check for Customer Data
        guard order["customer"] != nil else { continue }
        
        // Search for customer using fullname
        let customerFirstName = (order["customer"] as! [String:AnyObject])["first_name"] as! String
        let customerLastName = (order["customer"] as! [String:AnyObject])["last_name"] as! String
        let customerFullName = String(format:"%@ %@", customerFirstName, customerLastName)
        
        if customerFullName == "Napoleon Batz"
        {
          moneySpent = moneySpent + Double(order["total_price"] as! String)!
        }
        
        
      }
    }
    
  }
  
}
