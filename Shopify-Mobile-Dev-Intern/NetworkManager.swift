//
//  NetworkManager.swift
//  Shopify-Mobile-Dev-Intern
//
//  Created by Errol Cheong on 2017-09-05.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
  
  let datalink = "https://shopicruit.myshopify.com/admin/orders.json"
  
  func getShopifyData(completionHandler: @escaping ([String:AnyObject]?) -> Void)
  {
    var urlComponents = URLComponents(string: datalink)!
    let pageQuery = URLQueryItem(name: "page", value: "1")
    let tokenQuery = URLQueryItem(name: "access_token", value: "c32313df0d0ef512ca64d5b336a0d7c6")
    urlComponents.queryItems = [pageQuery, tokenQuery]
    
    let urlRequest = URLRequest(url: urlComponents.url!)
    
    let configuration = URLSessionConfiguration.default
    let session = URLSession(configuration: configuration)
    
    let dataTask = session.dataTask(with: urlRequest) { (data:Data?, response:URLResponse?, error:Error?) in
      if error == nil
      {
        do {
          
          let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:AnyObject]
          completionHandler(jsonData)
        } catch {
          print(error.localizedDescription)
        }
        
      } else {
        print(error!.localizedDescription)
        completionHandler(nil)
      }
    }
    
    dataTask.resume()
  }
}
