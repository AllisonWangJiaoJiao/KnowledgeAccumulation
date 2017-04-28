//
//  ViewController.swift
//  ApplePayDemo
//
//  Created by Allison on 2017/4/28.
//  Copyright © 2017年 Allison. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var productsArr : [SKProduct] = [SKProduct](){
        didSet{
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.从我们自己的服务器,获取需要销售的商品
      
         //2.拿到需要销售的商品,到苹果服务器,进行验证,看下哪些商品,才可以真正被销售
      
        YFDataTools.getGoodsList { (ids:Set<String>) ->() in
            //2.拿到需要销售的商品,到苹果服务器,进行验证,看下哪些商品,才可以真正被销售
            //2.1 创建一个商品请求,请求哪些商品可以真正的被销售
            let request :SKProductsRequest = SKProductsRequest(productIdentifiers: ids)
            
            //2.1.1设置代理
            request.delegate = self
            //2.2 发送请求
            request.start()
            
        }
        
        
    }
}

extension ViewController: SKProductsRequestDelegate{
    //当请求完毕之后,从苹果服务器获取到数据之后调用
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        //response
        //products 可以被销售的商品
        //invalidProductIdentifiers 无效的商品ID

        print("可以被销售的商品:\(response.products)")
        print("无效的商品ID :\(response.invalidProductIdentifiers)")
    }
    
}


extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCellID", for: indexPath)
        //获取对应的商品数据模型
        let product = productsArr[indexPath.row]
        
        cell.textLabel?.text = product.localizedTitle
        cell.textLabel?.text = product.localizedDescription + "\(product.price)"
        
        
        return cell
        
    }
}

