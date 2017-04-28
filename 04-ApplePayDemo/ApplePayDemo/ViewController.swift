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
    
    let cellID = "CustomTableViewCellID"
    
    @IBOutlet weak var tableView: UITableView!
    var productsArr : [SKProduct] = [SKProduct](){
        didSet{
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register( UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier:cellID)
        
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

        productsArr = response.products
        print("可以被销售的商品:\(response.products)")
        print("无效的商品ID :\(response.invalidProductIdentifiers)")
    }
    
}


extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CustomTableViewCell
        //获取对应的商品数据模型
        let product = productsArr[indexPath.row]
        
        cell.titleLab?.text = product.localizedTitle
        cell.subTitleLab?.text = product.localizedDescription + "\(product.price)"
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //取出需要购买的商品
        let product = productsArr[indexPath.row]
        
        //2.购买商品
        //2.1 根据商品,开一个支付小票
        let payment = SKPayment(product: product)
        //2.2添加到支付队列,开始进行购买队列
        SKPaymentQueue.default().add(payment)
        //2.3添加交易队列坚挺着,来监听交易状态
        SKPaymentQueue.default().add(self)
 
    }
}

//MARK:交易队列的监听者
extension ViewController : SKPaymentTransactionObserver{
    
    //当交易队列列名添加的每一笔交易状态发生变化的时候调用
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            switch transaction.transactionState {
            case .deferred:
                print("延时处理")
           
            case .failed:
                print("支付失败")
                
            case .purchased:
                print("支付成功")
                
            case .purchasing:
                print("正在支付")
                
            case .restored:
                print("恢复购买")
            }
            
            
        }
    }
    
}










